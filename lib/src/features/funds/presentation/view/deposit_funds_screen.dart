import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/core/config/mono_config.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/funds/cubit/deposit_cubit.dart';
import 'package:lazervault/src/features/funds/cubit/deposit_state.dart';
import 'package:lazervault/src/features/open_banking/cubit/open_banking_cubit.dart';
import 'package:lazervault/src/features/open_banking/cubit/open_banking_state.dart';
import 'package:lazervault/src/features/ai_scan_to_pay/presentation/widgets/mono_connect_widget.dart';
import 'package:lazervault/src/features/open_banking/domain/entities/deposit.dart';
import 'package:lazervault/src/features/funds/data/services/mono_institutions_service.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/pay_by_transfer_card.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/recurring_access_toggle.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/directpay_authorization_sheet.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/directpay_progress_bottomsheet.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:lazervault/src/features/widgets/service_voice_button.dart';

class DepositFundsScreen extends StatefulWidget {
  final Map<String, dynamic> selectedCard;
  const DepositFundsScreen({
    super.key,
    required this.selectedCard,
  });

  @override
  State<DepositFundsScreen> createState() => _DepositFundsScreenState();
}

class _DepositFundsScreenState extends State<DepositFundsScreen> {
  final TextEditingController _amountController = TextEditingController();
  final FlutterTts _flutterTts = FlutterTts();
  final stt.SpeechToText _speech = stt.SpeechToText();
  String _selectedBank = '';
  bool _isListening = false;
  String _recognizedText = '';
  bool _isVoiceEnabled = false;
  bool _wasSelectedFromBottomSheet = false;
  bool _isMonoLoading = false; // Loading state for Mono Connect

  // Dynamic bank list loaded from Mono supported banks
  List<Map<String, dynamic>> _banks = [];

  // Linked bank account ID (if user has linked an account)
  String? _linkedAccountId;

  // DirectPay vs Mandate toggle (NGN accounts)
  // false = DirectPay (one-time authorization per transaction)
  // true = Mandate (authorize once for recurring access)
  bool _useRecurringAccess = false;

  // DirectPay progress controller for animated bottomsheet
  final DirectPayProgressController _progressController = DirectPayProgressController();
  bool _isProgressSheetShown = false;

  List<Map<String, dynamic>> get _displayedBanks {
    if (_banks.isEmpty) return [];
    if (_selectedBank.isEmpty) return _banks.take(4).toList();
    if (!_wasSelectedFromBottomSheet) {
      return _banks.take(4).toList();
    }
    final selectedBankData = _banks.firstWhere((bank) => bank['name'] == _selectedBank, orElse: () => <String, dynamic>{});
    if (selectedBankData.isEmpty) return _banks.take(4).toList();

    final List<Map<String, dynamic>> reorderedBanks = [selectedBankData];
    reorderedBanks.addAll(_banks.where((bank) => bank['name'] != _selectedBank).take(3));
    return reorderedBanks;
  }

  /// Get currency from selected card
  String get _currency {
    final currency = widget.selectedCard['currency'] as String? ?? 'GBP';
    return currency.toUpperCase();
  }

  /// Check if NGN account (uses Mono direct debit flow)
  bool get _isNGN => _currency == 'NGN';

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
      default:
        return '₦';
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeSpeech();
    _loadBanks();
    // Listen to amount changes to update button state
    _amountController.addListener(_onAmountChanged);
  }

  /// Called when amount text changes
  void _onAmountChanged() {
    // Trigger rebuild to update button state
    if (mounted) {
      setState(() {});
    }
  }

  /// Load supported banks from Mono API
  ///
  /// Fetches the list of banks/institutions that Mono actually supports.
  /// This ensures users only see banks that will work with the deposit flow.
  Future<void> _loadBanks() async {
    try {
      // Fetch banks from Mono API (cached)
      final monoInstitutions = await MonoInstitutionsService.instance.getInstitutions();

      if (mounted) {
        setState(() {
          if (monoInstitutions.isNotEmpty) {
            // Convert Mono institution data to display format
            _banks = monoInstitutions.map((inst) => <String, dynamic>{
              'name': inst.name,
              'code': inst.bankCode ?? '',
              'monoId': inst.id, // Store Mono institution ID for later use
              'icon': Icons.account_balance,
              'color': _getBankColor(inst.name),
              'monoSupported': true,
              'supportsMobileBanking': inst.supportsMobileBanking,
              'supportsInternetBanking': inst.supportsInternetBanking,
            }).toList();

            // Sort alphabetically
            _banks.sort((a, b) =>
                (a['name'] as String).compareTo(b['name'] as String));
          } else {
            // Fallback to config banks if API returns empty
            final monoBanks = MonoConfig.supportedBanks;
            _banks = monoBanks.entries.map((entry) => <String, dynamic>{
              'name': entry.key,
              'code': entry.value,
              'monoId': MonoConfig.getMonoInstitutionId(entry.key), // May be null
              'icon': Icons.account_balance,
              'color': _getBankColor(entry.key),
              'monoSupported': true,
            }).toList();
          }
        });
      }
    } catch (e) {
      debugPrint('Error loading banks: $e');
      if (mounted) {
        // Fallback to letting Mono show its own bank selector
        setState(() {
          _banks = [];
        });
      }
    }
  }

  /// Get a consistent color for a bank based on its name
  Color _getBankColor(String bankName) {
    final colors = [
      Colors.blue, Colors.red, Colors.green, Colors.orange,
      Colors.purple, Colors.teal, Colors.indigo, Colors.pink,
    ];
    final index = bankName.hashCode.abs() % colors.length;
    return colors[index];
  }

  Future<void> _initializeSpeech() async {
    await _speech.initialize();
    await _flutterTts.setLanguage('en-GB');
    await _flutterTts.setPitch(1.0);
  }

  void _startListening() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (result) {
            setState(() {
              _recognizedText = result.recognizedWords;
              _processVoiceCommand(_recognizedText);
            });
          },
        );
      }
    }
  }

  void _stopListening() {
    _speech.stop();
    setState(() => _isListening = false);
  }

  void _processVoiceCommand(String command) {
    command = command.toLowerCase();

    // Process bank selection
    for (var bank in _banks) {
      if (command.contains(bank['name'].toLowerCase())) {
        setState(() => _selectedBank = bank['name']);
        _speakResponse('Selected ${bank['name']}');
        break;
      }
    }

    // Process amount
    final amountMatch = RegExp(r'\d+').firstMatch(command);
    if (amountMatch != null) {
      final amount = amountMatch.group(0);
      setState(() => _amountController.text = amount!);
      _speakResponse('Amount set to $_currencySymbol$amount');
    }
  }

  Future<void> _speakResponse(String text) async {
    await _flutterTts.speak(text);
  }

  void _showAllBanksBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (context) => _BankSearchBottomSheet(
        banks: _banks,
        selectedBank: _selectedBank,
        onBankSelected: (bankName) {
          _selectBank(bankName, fromBottomSheet: true);
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<DepositCubit>()),
        BlocProvider(create: (_) => serviceLocator<OpenBankingCubit>()),
      ],
      child: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, authState) {
          if (authState is! AuthenticationSuccess) {
            Get.snackbar('Authentication Error', 'You need to be logged in to make a deposit.',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red.withValues(alpha: 0.7),
              colorText: Colors.white
            );
          }
        },
        builder: (authContext, authState) {
          return Scaffold(
            backgroundColor: const Color(0xFF1A1A1A),
            appBar: _buildAppBar(),
            body: BlocListener<OpenBankingCubit, OpenBankingState>(
              listener: _openBankingListener,
              child: BlocConsumer<DepositCubit, DepositState>(
                listener: _blocListener,
                builder: (context, state) {
                  final isLoading = state is DepositLoading;
                  final openBankingState = context.watch<OpenBankingCubit>().state;
                  final isOpenBankingLoading = openBankingState is OpenBankingLoading ||
                                               openBankingState is AccountLinkingInProgress;
                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(24.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSelectedCardSummary(),
                          SizedBox(height: 24.h),
                          // NGN accounts use Mono direct debit flow
                          if (_isNGN) ...[
                            _buildNGNMonoDirectDebitView(context, isLoading || isOpenBankingLoading),
                          ] else ...[
                            // Other currencies (GBP, USD, EUR) use standard flow
                            _buildMonoInfoBanner(),
                            SizedBox(height: 16.h),
                            if (_isVoiceEnabled) _buildVoiceCommandStatus(),
                            if (_isVoiceEnabled) SizedBox(height: 24.h),
                            _buildBankSelectionHeader(),
                            SizedBox(height: 16.h),
                            _buildBankSelectionGrid(isLoading || isOpenBankingLoading),
                            SizedBox(height: 24.h),
                            _buildAmountInput(isLoading || isOpenBankingLoading),
                            SizedBox(height: 24.h),
                            _buildQuickAmounts(isLoading || isOpenBankingLoading),
                            SizedBox(height: 32.h),
                            _buildDepositButton(context, isLoading || isOpenBankingLoading),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  /// Mono info banner showing open banking message
  Widget _buildMonoInfoBanner() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF4E03D0).withValues(alpha: 0.1),
            const Color(0xFF5F14E1).withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: const Color(0xFF4E03D0).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.security,
              color: const Color(0xFF4E03D0),
              size: 24.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Secure Open Banking',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Powered by Mono. Your bank credentials are never stored.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// NGN Mono Direct Debit View - Shows amount input, Mono open banking info and button to link bank
  /// User enters amount first, then links their bank via Mono
  /// After linking, the deposit is initiated via Mono DirectPay API
  /// Also includes Pay by Transfer option as an alternative
  Widget _buildNGNMonoDirectDebitView(BuildContext context, bool isLoading) {
    // Extract account details for Pay by Transfer card
    final accountNumber = widget.selectedCard['accountNumber'] ??
                          widget.selectedCard['account_number'] ?? '';
    final accountName = widget.selectedCard['accountName'] ??
                        widget.selectedCard['account_name'] ?? 'LazerVault Account';
    final bankName = widget.selectedCard['bankName'] ??
                     widget.selectedCard['bank_name'] ?? 'Wema Bank';

    // Get user ID for simulation
    String? userId;
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is AuthenticationSuccess) {
      userId = authState.profile.user.id;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Amount Input Section for NGN
        Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Deposit Amount',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 12.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '₦',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      decoration: InputDecoration(
                        hintText: '0.00',
                        hintStyle: TextStyle(
                          color: Colors.white.withValues(alpha: 0.3),
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Text(
                'Min: ₦200 • Max: ₦1,000,000',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.h),

        // ==== LINK BANK & DEPOSIT SECTION (Primary Action) ====
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF6C5CE7).withValues(alpha: 0.2),
                const Color(0xFF6C5CE7).withValues(alpha: 0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            children: [
              // Header with icon and title
              Row(
                children: [
                  Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6C5CE7), Color(0xFF8E7CF3)],
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      Icons.account_balance,
                      color: Colors.white,
                      size: 24.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Link Bank & Deposit',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'Securely deposit from your bank via Mono',
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
              SizedBox(height: 16.h),

              // Recurring Access Toggle
              RecurringAccessToggle(
                isRecurringEnabled: _useRecurringAccess,
                onToggle: (value) {
                  setState(() => _useRecurringAccess = value);
                },
              ),
              SizedBox(height: 16.h),

              // Link & Deposit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : () => _launchNGNMonoBottomsheet(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C5CE7),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 0,
                  ),
                  child: isLoading
                      ? SizedBox(
                          height: 22.h,
                          width: 22.w,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.link, size: 20.sp),
                            SizedBox(width: 8.w),
                            Text(
                              'Link & Deposit',
                              style: TextStyle(
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
        ),
        SizedBox(height: 24.h),

        // ==== OR DIVIDER ====
        Row(
          children: [
            Expanded(
              child: Container(
                height: 1,
                color: Colors.white.withValues(alpha: 0.2),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                'OR',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 1,
                color: Colors.white.withValues(alpha: 0.2),
              ),
            ),
          ],
        ),
        SizedBox(height: 24.h),

        // ==== PAY BY TRANSFER CARD ====
        PayByTransferCard(
          accountNumber: accountNumber,
          accountName: accountName,
          bankName: bankName,
          accountId: widget.selectedCard['id'] is String
              ? widget.selectedCard['id'] as String
              : widget.selectedCard['id']?.toString(),
          userId: userId,
          onSimulationComplete: () {
            // WebSocket handles balance update - no manual refresh needed
            _refreshAccountBalances(context);

            // Navigate to dashboard IMMEDIATELY so user sees the balance animation
            if (mounted && Navigator.canPop(context)) {
              Navigator.of(context).pop();
            }
          },
        ),
        SizedBox(height: 24.h),

        // ==== HOW MONO DIRECT DEBIT WORKS (Info Section) ====
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Colors.white.withValues(alpha: 0.7),
                    size: 18.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'How Mono Direct Debit Works',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              _buildInfoItem(Icons.lock_outline, 'Bank-grade security'),
              SizedBox(height: 8.h),
              _buildInfoItem(Icons.flash_on, 'Instant deposits'),
              SizedBox(height: 8.h),
              _buildInfoItem(Icons.credit_card_off, 'No card details needed'),
            ],
          ),
        ),
        SizedBox(height: 16.h),

        // Terms text
        Text(
          'By continuing, you agree to Mono\'s End-user Policy. Mono will have read-only access to your account.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.5),
            fontSize: 11.sp,
            height: 1.4,
          ),
        ),
        SizedBox(height: 24.h),
      ],
    );
  }

  /// Info item widget for the "How Mono Works" section
  Widget _buildInfoItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(0xFF6C5CE7),
          size: 16.sp,
        ),
        SizedBox(width: 8.w),
        Text(
          text,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }

  /// Launch the NGN Mono Connect SDK with DirectPay/Mandate support
  void _launchNGNMonoBottomsheet(BuildContext context) async {
    // Validate amount first
    final amountText = _amountController.text.trim();
    final amount = double.tryParse(amountText) ?? 0;

    if (amount < 200) {
      Get.snackbar(
        'Invalid Amount',
        'Minimum deposit amount is ₦200',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.9),
        colorText: Colors.white,
      );
      return;
    }

    if (amount > 1000000) {
      Get.snackbar(
        'Invalid Amount',
        'Maximum deposit amount is ₦1,000,000',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.9),
        colorText: Colors.white,
      );
      return;
    }

    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) {
      Get.snackbar(
        'Authentication Error',
        'You need to be logged in to make a deposit.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.7),
        colorText: Colors.white,
      );
      return;
    }

    if (!MonoConfig.isEnabled) {
      Get.snackbar(
        'Configuration Error',
        'Open banking is not configured. Please contact support.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.9),
        colorText: Colors.white,
      );
      return;
    }

    debugPrint('[MonoConnect] Amount validated: ₦$amount');
    debugPrint('[MonoConnect] Recurring access mode: $_useRecurringAccess');

    final user = authState.profile.user;
    final userId = user.id;
    final accessToken = authState.profile.session.accessToken;
    final customerName = '${user.firstName} ${user.lastName}'.trim();
    final customerEmail = user.email;

    debugPrint('[MonoConnect] Launching Mono Connect SDK');
    debugPrint('[MonoConnect] Customer: $customerName ($customerEmail)');
    debugPrint('[MonoConnect] User ID: $userId');

    // Launch Mono Connect SDK
    final result = await showMonoConnectBottomSheet(
      context: context,
      publicKey: MonoConfig.publicKey,
      customerName: customerName.isNotEmpty ? customerName : null,
      customerEmail: customerEmail.isNotEmpty ? customerEmail : null,
      reference: 'lzv_deposit_${DateTime.now().millisecondsSinceEpoch}',
    );

    if (result != null) {
      debugPrint('[MonoConnect] Success - Code: ${result.code.substring(0, result.code.length > 10 ? 10 : result.code.length)}...');
      debugPrint('[MonoConnect] Institution: ${result.institutionName ?? result.institutionId ?? 'unknown'}');

      // Show progress bottomsheet
      _progressController.show(
        bankName: result.institutionName ?? 'Bank',
        amount: amount,
        currency: _currency,
      );
      _showProgressBottomsheet(context);

      // Link the account using the OpenBankingCubit
      context.read<OpenBankingCubit>().linkAccount(
        userId: userId,
        code: result.code,
        accessToken: accessToken,
      );
    } else {
      debugPrint('[MonoConnect] User cancelled or closed');
    }
  }

  /// Show the DirectPay progress bottomsheet
  void _showProgressBottomsheet(BuildContext context) {
    if (_isProgressSheetShown) return;
    _isProgressSheetShown = true;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      builder: (sheetContext) => DirectPayProgressBottomsheet(
        controller: _progressController,
        onSuccess: () {
          _isProgressSheetShown = false;
          Navigator.of(sheetContext).pop();
          // Navigate back to dashboard
          _navigateToDashboard();
        },
        onDismiss: () {
          _isProgressSheetShown = false;
          Navigator.of(sheetContext).pop();
        },
      ),
    ).whenComplete(() {
      _isProgressSheetShown = false;
    });
  }

  /// Navigate back to dashboard after successful deposit
  void _navigateToDashboard() {
    // Clear form
    _amountController.clear();
    setState(() {
      _selectedBank = '';
      _wasSelectedFromBottomSheet = false;
      _linkedAccountId = null;
    });

    // Navigate back
    if (mounted && Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }
  }

  /// Handle DirectPay authorization in-app using WebView
  Future<void> _handleDirectPayAuth(String paymentUrl, String paymentId) async {
    debugPrint('[DirectPay] Opening authorization WebView for payment: $paymentId');
    debugPrint('[DirectPay] URL: $paymentUrl');

    final result = await showDirectPayAuthorizationSheet(
      context: context,
      paymentUrl: paymentUrl,
      paymentId: paymentId,
      redirectScheme: 'lazervault',
      redirectPath: '/deposit/callback',
    );

    if (result.success) {
      debugPrint('[DirectPay] Authorization successful');
      // Update progress to processing stage
      _progressController.updateStage(DirectPayStage.processing);
      // Refresh balances after successful authorization
      _refreshAccountBalances(context);
    } else {
      debugPrint('[DirectPay] Authorization failed: ${result.errorMessage}');
      _progressController.updateStage(
        DirectPayStage.failed,
        errorMessage: result.errorMessage ?? 'Payment authorization was cancelled',
      );
    }
  }

  /// Handle open banking state changes
  void _openBankingListener(BuildContext context, OpenBankingState state) {
    debugPrint('[Deposit] OpenBankingListener received state: ${state.runtimeType}');

    if (state is AccountLinked) {
      // Account successfully linked
      debugPrint('[Deposit] Account linked: ${state.account.id}, bankName: ${state.account.bankName}');
      setState(() {
        _linkedAccountId = state.account.id;
      });

      // Update progress to initiating stage
      _progressController.updateStage(DirectPayStage.initiating);

      // For all currencies (including NGN), initiate the deposit after linking
      // The Mono Connect SDK only LINKS the account - we must call InitiateDeposit
      // to trigger the Mono DirectPay API which debits the user's bank
      debugPrint('[Deposit] Calling _proceedWithMonoDeposit with linkedAccountId: $_linkedAccountId');
      _proceedWithMonoDeposit(context);
    } else if (state is DepositInitiated) {
      // Deposit initiated - check if DirectPay authorization is needed
      final deposit = state.deposit;
      debugPrint('[Deposit] Deposit initiated: ${deposit.id}');

      if (deposit.requiresAuthorization &&
          deposit.paymentUrl != null &&
          deposit.paymentUrl!.isNotEmpty) {
        // DirectPay authorization needed - update progress and open in-app WebView
        debugPrint('[Deposit] DirectPay authorization required: ${deposit.paymentUrl}');
        _progressController.updateStage(DirectPayStage.authorizing);
        _handleDirectPayAuth(
          deposit.paymentUrl!,
          deposit.paymentId ?? deposit.id,
        );
      } else {
        // No authorization needed (mandate already approved or instant)
        _progressController.updateStage(DirectPayStage.processing);
      }
    } else if (state is DepositStatusUpdated) {
      // Check deposit status
      final deposit = state.deposit;
      if (deposit.status == DepositStatus.successful) {
        // Deposit completed - refresh balances
        _refreshAccountBalances(context);

        // Update progress to success
        _progressController.updateStage(DirectPayStage.success);

        // Navigation will be handled by the progress sheet's onSuccess callback
      } else if (deposit.status == DepositStatus.failed) {
        _progressController.updateStage(
          DirectPayStage.failed,
          errorMessage: deposit.failureReason ?? 'The deposit could not be completed.',
        );
      }
    } else if (state is OpenBankingError) {
      debugPrint('[Deposit] OpenBankingError: ${state.message}, operation: ${state.operation}');
      _progressController.updateStage(
        DirectPayStage.failed,
        errorMessage: state.message,
      );
    }
  }
  
  void _blocListener(BuildContext context, DepositState state) {
    if (state is DepositFailure) {
      Get.closeAllSnackbars();
      Get.snackbar(
        'Deposit Failed',
        state.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.9),
        colorText: Colors.white,
        isDismissible: true,
        duration: const Duration(seconds: 5),
        margin: EdgeInsets.all(16.w),
        borderRadius: 12.r,
        icon: Icon(
          Icons.error_outline_rounded,
          color: Colors.white,
          size: 28.sp,
        ),
      );
      // DO NOT navigate on error - stay on screen
    } else if (state is DepositSuccess) {
      Get.closeAllSnackbars();
      Get.snackbar(
        'Deposit Initiated',
        'Your deposit of $_currencySymbol${_amountController.text} from $_selectedBank is being processed.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue.withValues(alpha: 0.9),
        colorText: Colors.white,
        isDismissible: true,
        duration: const Duration(seconds: 3),
        margin: EdgeInsets.all(16.w),
        borderRadius: 12.r,
        icon: Icon(
          Icons.hourglass_top_rounded,
          color: Colors.white,
          size: 28.sp,
        ),
      );
    } else if (state is DepositWebSocketCompleted) {
      Get.closeAllSnackbars();
      Get.snackbar(
        'Deposit Completed',
        'Your deposit has been completed successfully.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withValues(alpha: 0.9),
        colorText: Colors.white,
        isDismissible: true,
        duration: const Duration(seconds: 3),
        margin: EdgeInsets.all(16.w),
        borderRadius: 12.r,
        icon: Icon(
          Icons.check_circle_rounded,
          color: Colors.white,
          size: 28.sp,
        ),
      );

      // Clear form
      _amountController.clear();
      setState(() {
        _selectedBank = '';
        _wasSelectedFromBottomSheet = false;
      });

      // Refresh account balances
      _refreshAccountBalances(context);

      // Navigate back to dashboard after delay
      Future.delayed(const Duration(seconds: 2), () {
        if (!mounted) return;
        if (Navigator.canPop(context)) {
          Navigator.of(context).pop();
        }
      });
    } else if (state is DepositReversed) {
      Get.closeAllSnackbars();
      Get.snackbar(
        'Deposit Reversed',
        state.reason,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.withValues(alpha: 0.9),
        colorText: Colors.white,
        isDismissible: true,
        duration: const Duration(seconds: 6),
        margin: EdgeInsets.all(16.w),
        borderRadius: 12.r,
        icon: Icon(
          Icons.undo_rounded,
          color: Colors.white,
          size: 28.sp,
        ),
      );

      // Refresh balances since reversal affects the balance
      _refreshAccountBalances(context);
    } else if (state is DepositWebSocketFailed) {
      Get.closeAllSnackbars();
      Get.snackbar(
        'Deposit Failed',
        state.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.9),
        colorText: Colors.white,
        isDismissible: true,
        duration: const Duration(seconds: 5),
        margin: EdgeInsets.all(16.w),
        borderRadius: 12.r,
        icon: Icon(
          Icons.error_outline_rounded,
          color: Colors.white,
          size: 28.sp,
        ),
      );
    }
  }
  
  /// Refreshes the account balances - DISABLED: WebSocket handles real-time updates
  /// The ws-balance-service pushes balance updates to the Flutter app via WebSocket,
  /// which triggers the balance animation on the dashboard automatically.
  void _refreshAccountBalances(BuildContext context) {
    // REMOVED: Manual refresh is no longer needed - WebSocket handles balance updates
    // The dashboard will receive the update via BalanceWebSocketCubit and show animation
    print('Manual refresh skipped - WebSocket will handle balance update');
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        'Deposit Funds',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            _isVoiceEnabled ? Icons.mic : Icons.mic_off,
            color: _isVoiceEnabled ? const Color(0xFF3498DB) : Colors.white,
          ),
          onPressed: () {
            setState(() {
              _isVoiceEnabled = !_isVoiceEnabled;
              if (_isVoiceEnabled) {
                _startListening();
              } else {
                _stopListening();
              }
            });
          },
        ),
            ServiceVoiceButton(
        serviceName: 'loans',
      ),
],
    );
  }

  Widget _buildSelectedCardSummary() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 78, 3, 208),
            Color.fromARGB(255, 95, 20, 225),
          ],
        ),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.selectedCard['accountType'],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 6.h,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  widget.selectedCard['accountNumber'],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Text(
            "$_currencySymbol${widget.selectedCard['balance'].toStringAsFixed(2)}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 32.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 6.h,
                ),
                decoration: BoxDecoration(
                  color: widget.selectedCard['isUp']
                      ? Colors.green.withValues(alpha: 0.2)
                      : Colors.red.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  widget.selectedCard['trend'],
                  style: TextStyle(
                    color: widget.selectedCard['isUp']
                        ? Colors.green[300]
                        : Colors.red[300],
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

  Widget _buildVoiceCommandStatus() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF3498DB).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
      ),
      child: Row(
        children: [
          Icon(
            Icons.mic,
            color: const Color(0xFF3498DB),
            size: 24.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              _isListening
                  ? 'Listening...'
                  : 'Voice commands enabled. Try saying "Select Barclays" or "Deposit 500 pounds"',
              style: TextStyle(
                color: const Color(0xFF3498DB),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBankSelectionHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Select Your Bank',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF3498DB).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: TextButton.icon(
            onPressed: _showAllBanksBottomSheet,
            icon: Icon(
              Icons.arrow_forward_ios,
              color: const Color(0xFF3498DB),
              size: 16.sp,
            ),
            label: Text(
              'View All',
              style: TextStyle(
                color: const Color(0xFF3498DB),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 8.h,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBankSelectionGrid(bool isLoading) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.w,
        mainAxisSpacing: 8.h,
      ),
      itemCount: _displayedBanks.length,
      itemBuilder: (context, index) {
        final bank = _displayedBanks[index];
        final isSelected = _selectedBank == bank['name'];
        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: isLoading ? null : () => _selectBank(bank['name']),
            borderRadius: BorderRadius.circular(8.r),
            child: Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: isSelected
                    ? bank['color'].withValues(alpha: 0.2)
                    : Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(8.r),
                border: isSelected
                    ? Border.all(color: bank['color'], width: 2)
                    : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: bank['color'].withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      bank['icon'],
                      color: bank['color'],
                      size: 16.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    bank['name'],
                    style: TextStyle(
                      color:
                          isSelected ? bank['color'] : Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.2,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAmountInput(bool isLoading) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Enter Amount',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 8.h,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  _currencySymbol,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: TextField(
                  controller: _amountController,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '0.00',
                    hintStyle: TextStyle(
                      color: Colors.white.withValues(alpha: 0.3),
                      fontSize: 24.sp,
                    ),
                  ),
                  enabled: !isLoading,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickAmounts(bool isLoading) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Amounts',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildQuickAmountButton('${_currencySymbol}100', isLoading),
            _buildQuickAmountButton('${_currencySymbol}500', isLoading),
            _buildQuickAmountButton('${_currencySymbol}1000', isLoading),
            _buildQuickAmountButton('${_currencySymbol}2000', isLoading),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickAmountButton(String amount, bool isLoading) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isLoading ? null : () {
          // Remove any currency symbol to get the numeric value
          final numericAmount = amount.replaceAll(RegExp(r'[₦£\$€]'), '');
          setState(() => _amountController.text = numericAmount);
        },
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
          ),
          child: Text(
            amount,
            style: TextStyle(
              color: isLoading ? Colors.white.withValues(alpha: 0.3) : Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDepositButton(BuildContext buildContext, bool isLoading) {
    final amount = double.tryParse(_amountController.text) ?? 0;
    final isValid = _selectedBank.isNotEmpty && amount > 0;
    // Combined loading state: Mono Connect opening OR deposit processing
    final isAnyLoading = isLoading || _isMonoLoading;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: isValid && !isAnyLoading
            ? [
                BoxShadow(
                  color: const Color(0xFF10B981).withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ]
            : [],
      ),
      child: ElevatedButton(
        onPressed: !isValid || isAnyLoading ? null : () => _handleDeposit(buildContext),
        style: ElevatedButton.styleFrom(
          backgroundColor: isValid && !isAnyLoading
              ? const Color(0xFF10B981)
              : Colors.grey.shade700,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 18.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          elevation: 0,
          minimumSize: Size(double.infinity, 56.h),
        ),
        child: _buildDepositButtonContent(isLoading, amount),
      ),
    );
  }

  /// Build the deposit button content based on loading states
  Widget _buildDepositButtonContent(bool isProcessingDeposit, double amount) {
    // Show Mono Connect loading state
    if (_isMonoLoading) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 20.h,
            width: 20.w,
            child: const CircularProgressIndicator(
              strokeWidth: 2.5,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          SizedBox(width: 12.w),
          Text(
            'Connecting to bank...',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ],
      );
    }

    // Show deposit processing state
    if (isProcessingDeposit) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 20.h,
            width: 20.w,
            child: const CircularProgressIndicator(
              strokeWidth: 2.5,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          SizedBox(width: 12.w),
          Text(
            'Processing Deposit...',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ],
      );
    }

    // Default state - show deposit button text
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Transform.rotate(
          angle: -0.785398, // -45 degrees in radians (up-right arrow)
          child: Icon(
            Icons.arrow_upward_rounded,
            size: 22.sp,
          ),
        ),
        SizedBox(width: 12.w),
        Text(
          amount > 0 ? 'Deposit $_currencySymbol${amount.toStringAsFixed(2)}' : 'Deposit Funds',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  void _handleDeposit(BuildContext buildContext) {
    FocusScope.of(buildContext).unfocus();

    if (_selectedBank.isEmpty) {
      Get.snackbar('Error', 'Please select a source bank.', snackPosition: SnackPosition.BOTTOM);
      return;
    }
    final amount = double.tryParse(_amountController.text);
    if (amount == null || amount <= 0) {
      Get.snackbar('Error', 'Please enter a valid positive amount.', snackPosition: SnackPosition.BOTTOM);
      return;
    }

    // Check if Mono is enabled
    if (!MonoConfig.isEnabled) {
      Get.snackbar(
        'Configuration Error',
        'Open banking is not configured. Please contact support.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.9),
        colorText: Colors.white,
      );
      return;
    }

    // Get the Mono institution ID from the bank data (fetched from Mono API)
    String? institutionId;
    try {
      final selectedBankData = _banks.firstWhere(
        (bank) => bank['name'] == _selectedBank,
        orElse: () => <String, dynamic>{},
      );
      institutionId = selectedBankData['monoId'] as String?;
    } catch (_) {
      institutionId = null;
    }

    debugPrint('[Deposit] Selected bank: $_selectedBank, institutionId: $institutionId');

    // If we don't have a valid institution ID, let Mono show its bank selector
    // This is better than using an incorrect ID that causes errors
    if (institutionId == null || institutionId.isEmpty) {
      debugPrint('[Deposit] No institution ID found - Mono will show bank selector');
    }

    // Launch Mono Connect to link bank account and authorize deposit
    _launchMonoConnect(buildContext, institutionId);
  }

  /// Launch Mono Connect widget to link bank and authorize deposit
  Future<void> _launchMonoConnect(BuildContext buildContext, String? institutionId) async {
    final authState = buildContext.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) {
      Get.snackbar(
        'Authentication Error',
        'You need to be logged in to make a deposit.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.7),
        colorText: Colors.white
      );
      return;
    }

    // Set loading state while Mono Connect opens
    setState(() {
      _isMonoLoading = true;
    });

    final userId = authState.profile.user.id;
    final user = authState.profile.user;
    final reference = 'deposit_${userId}_${DateTime.now().millisecondsSinceEpoch}';

    // Get customer info for Mono
    final customerName = '${user.firstName} ${user.lastName}'.trim();
    final customerEmail = user.email;

    MonoConnectResult? result;
    try {
      // Show Mono Connect using native SDK
      // With selectedInstitution, the bank selection screen is skipped
      result = await showMonoConnectBottomSheet(
        context: buildContext,
        publicKey: MonoConfig.publicKey,
        institutionId: institutionId,
        reference: reference,
        title: _selectedBank.isNotEmpty ? 'Link $_selectedBank' : 'Link Bank Account',
        customerName: customerName.isNotEmpty ? customerName : null,
        customerEmail: customerEmail,
      );
    } finally {
      // Clear loading state when Mono Connect closes
      if (mounted) {
        setState(() {
          _isMonoLoading = false;
        });
      }
    }

    if (result != null) {
      // Successfully got result - check if user changed bank in Mono flow
      String bankName = _selectedBank;
      if (result.institutionName != null && result.institutionName!.isNotEmpty) {
        // Try to find matching bank name in our list
        final monoInstitutionName = result.institutionName!;
        final matchingBank = _findMatchingBankName(monoInstitutionName);

        if (matchingBank != null && matchingBank != _selectedBank) {
          // User selected a different bank in Mono - update our selection
          debugPrint('[Deposit] Bank changed in Mono: $_selectedBank -> $matchingBank');
          bankName = matchingBank;
          setState(() {
            _selectedBank = matchingBank;
          });
        }
      }

      // Show progress bottomsheet
      final amount = double.tryParse(_amountController.text) ?? 0;
      _progressController.show(
        bankName: result.institutionName ?? bankName,
        amount: amount,
        currency: _currency,
      );
      _showProgressBottomsheet(buildContext);

      // Link the account with the auth code
      final accessToken = authState.profile.session.accessToken;
      if (mounted) {
        buildContext.read<OpenBankingCubit>().linkAccount(
          userId: userId,
          code: result.code,
          accessToken: accessToken,
          setAsDefault: true,
        );
      }
    } else {
      // User cancelled or error occurred
      Get.snackbar(
        'Cancelled',
        'Bank linking was cancelled. Please try again to make a deposit.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.grey.withValues(alpha: 0.9),
        colorText: Colors.white,
      );
    }
  }

  /// Find matching bank name in our list from Mono's institution name
  String? _findMatchingBankName(String monoInstitutionName) {
    final lowerMonoName = monoInstitutionName.toLowerCase();

    // First try exact match
    for (final bank in _banks) {
      final bankName = bank['name'] as String? ?? '';
      if (bankName.toLowerCase() == lowerMonoName) {
        return bankName;
      }
    }

    // Try fuzzy match (contains)
    for (final bank in _banks) {
      final bankName = bank['name'] as String? ?? '';
      if (bankName.toLowerCase().contains(lowerMonoName) ||
          lowerMonoName.contains(bankName.toLowerCase())) {
        return bankName;
      }
    }

    // Try matching by key words
    final monoWords = lowerMonoName.split(' ').where((w) => w.length > 2).toList();
    for (final bank in _banks) {
      final bankName = bank['name'] as String? ?? '';
      final bankNameLower = bankName.toLowerCase();
      for (final word in monoWords) {
        if (bankNameLower.contains(word)) {
          return bankName;
        }
      }
    }

    return null;
  }

  /// Proceed with deposit after account is linked
  void _proceedWithMonoDeposit(BuildContext buildContext) {
    debugPrint('[Deposit] _proceedWithMonoDeposit called');

    final authState = buildContext.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) {
      debugPrint('[Deposit] ERROR: User not authenticated');
      return;
    }

    final amountText = _amountController.text;
    final amount = double.tryParse(amountText) ?? 0;
    debugPrint('[Deposit] Amount text: "$amountText", parsed amount: $amount, linkedAccountId: $_linkedAccountId');

    if (amount <= 0) {
      debugPrint('[Deposit] ERROR: Amount is <= 0, cannot proceed');
      Get.snackbar(
        'Error',
        'Please enter a valid deposit amount.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.9),
        colorText: Colors.white,
      );
      return;
    }

    if (_linkedAccountId == null) {
      debugPrint('[Deposit] ERROR: linkedAccountId is null');
      Get.snackbar(
        'Error',
        'Bank account not linked. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.9),
        colorText: Colors.white,
      );
      return;
    }

    final userId = authState.profile.user.id;
    final accessToken = authState.profile.session.accessToken;

    // Get destination account ID
    String? destinationAccountId;
    if (widget.selectedCard['id'] is int) {
      destinationAccountId = widget.selectedCard['id'].toString();
    } else if (widget.selectedCard['id'] is String) {
      destinationAccountId = widget.selectedCard['id'] as String;
    }
    debugPrint('[Deposit] Destination account ID: $destinationAccountId (from widget.selectedCard["id"]: ${widget.selectedCard['id']})');

    if (destinationAccountId == null) {
      debugPrint('[Deposit] ERROR: destinationAccountId is null');
      Get.snackbar(
        'Error',
        'Invalid account information. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.9),
        colorText: Colors.white,
      );
      return;
    }

    debugPrint('[Deposit] Initiating deposit: userId=$userId, linkedAccountId=$_linkedAccountId, destAccountId=$destinationAccountId, amount=$amount');

    // Initiate deposit via open banking
    buildContext.read<OpenBankingCubit>().initiateDeposit(
      userId: userId,
      linkedAccountId: _linkedAccountId!,
      destinationAccountId: destinationAccountId,
      amount: amount,
      narration: 'Deposit from $_selectedBank to LazerVault',
      accessToken: accessToken,
    );
  }

  void _selectBank(String bankName, {bool fromBottomSheet = false}) {
    setState(() {
      _selectedBank = bankName;
      _wasSelectedFromBottomSheet = fromBottomSheet;
    });
  }

  @override
  void dispose() {
    _amountController.removeListener(_onAmountChanged);
    _amountController.dispose();
    _flutterTts.stop();
    _speech.cancel();
    _progressController.dispose();
    super.dispose();
  }
}

/// Bottom sheet widget with bank search functionality
class _BankSearchBottomSheet extends StatefulWidget {
  final List<Map<String, dynamic>> banks;
  final String selectedBank;
  final Function(String) onBankSelected;

  const _BankSearchBottomSheet({
    required this.banks,
    required this.selectedBank,
    required this.onBankSelected,
  });

  @override
  State<_BankSearchBottomSheet> createState() => _BankSearchBottomSheetState();
}

class _BankSearchBottomSheetState extends State<_BankSearchBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredBanks = [];

  @override
  void initState() {
    super.initState();
    _filteredBanks = widget.banks;
    _searchController.addListener(_filterBanks);
  }

  void _filterBanks() {
    final query = _searchController.text.toLowerCase().trim();
    setState(() {
      if (query.isEmpty) {
        _filteredBanks = widget.banks;
      } else {
        _filteredBanks = widget.banks.where((bank) {
          final bankName = (bank['name'] as String? ?? '').toLowerCase();
          return bankName.contains(query);
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterBanks);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Select Bank',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          // Search field
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: TextField(
              controller: _searchController,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
              ),
              decoration: InputDecoration(
                hintText: 'Search banks...',
                hintStyle: TextStyle(
                  color: Colors.white.withValues(alpha: 0.4),
                  fontSize: 16.sp,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white.withValues(alpha: 0.5),
                  size: 22.sp,
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(
                          Icons.clear,
                          color: Colors.white.withValues(alpha: 0.5),
                          size: 20.sp,
                        ),
                        onPressed: () {
                          _searchController.clear();
                        },
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 14.h,
                ),
              ),
              autofocus: true,
            ),
          ),
          SizedBox(height: 16.h),
          // Results count
          if (_searchController.text.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Text(
                '${_filteredBanks.length} bank${_filteredBanks.length == 1 ? '' : 's'} found',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 13.sp,
                ),
              ),
            ),
          // Bank list
          Expanded(
            child: _filteredBanks.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          color: Colors.white.withValues(alpha: 0.3),
                          size: 48.sp,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'No banks found',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.5),
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Try a different search term',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.3),
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredBanks.length,
                    itemBuilder: (context, index) {
                      final bank = _filteredBanks[index];
                      final isSelected = widget.selectedBank == bank['name'];
                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => widget.onBankSelected(bank['name']),
                          borderRadius: BorderRadius.circular(16.r),
                          child: Container(
                            margin: EdgeInsets.only(bottom: 12.h),
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? bank['color'].withValues(alpha: 0.1)
                                  : Colors.white.withValues(alpha: 0.05),
                              borderRadius: BorderRadius.circular(16.r),
                              border: isSelected
                                  ? Border.all(color: bank['color'], width: 2)
                                  : null,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8.w),
                                  decoration: BoxDecoration(
                                    color: bank['color'].withValues(alpha: 0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    bank['icon'],
                                    color: bank['color'],
                                    size: 24.sp,
                                  ),
                                ),
                                SizedBox(width: 16.w),
                                Expanded(
                                  child: Text(
                                    bank['name'],
                                    style: TextStyle(
                                      color: isSelected
                                          ? bank['color']
                                          : Colors.white,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.2,
                                    ),
                                  ),
                                ),
                                if (isSelected)
                                  Container(
                                    padding: EdgeInsets.all(4.w),
                                    decoration: BoxDecoration(
                                      color: bank['color'],
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 16.sp,
                                    ),
                                  ),
                              ],
                            ),
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
