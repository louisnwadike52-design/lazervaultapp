import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/core/utilities/banks_data.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/funds/cubit/withdrawal_cubit.dart';
import 'package:lazervault/src/features/funds/cubit/withdrawal_state.dart';

class WithdrawFundsScreen extends StatefulWidget {
  final Map<String, dynamic> selectedCard;
  const WithdrawFundsScreen({
    super.key,
    required this.selectedCard,
  });

  @override
  State<WithdrawFundsScreen> createState() => _WithdrawFundsScreenState();
}

class _WithdrawFundsScreenState extends State<WithdrawFundsScreen> {
  final TextEditingController _amountController = TextEditingController();
  final FlutterTts _flutterTts = FlutterTts();
  final stt.SpeechToText _speech = stt.SpeechToText();
  String _selectedBank = '';
  bool _isProcessing = false;
  bool _isListening = false;
  String _recognizedText = '';
  bool _isVoiceEnabled = false;
  // Dynamic bank list loaded from API
  List<Map<String, dynamic>> _banks = [];

  @override
  void initState() {
    super.initState();
    _initializeSpeech();
    _loadBanks();
  }

  /// Load supported banks from local configuration
  Future<void> _loadBanks() async {
    setState(() {});
    try {
      // Get country from selected card or default to NG
      final String country = _getCountryFromCard();
      // Use local banks data only - no API calls
      final banks = BanksData.getBanksForCountry(country);

      if (mounted) {
        setState(() {
          // Convert bank data to display format
          _banks = banks.map((bank) => {
            'name': bank['name'] ?? bank['bankName'] ?? 'Unknown Bank',
            'code': bank['code'] ?? bank['bankCode'] ?? '',
            'icon': Icons.account_balance,
            'color': _getBankColor(bank['name'] ?? bank['bankName'] ?? ''),
          }).toList();
        });
      }
    } catch (e) {
      print('Error loading banks: $e');
      if (mounted) {
        setState(() {});
      }
    }
  }

  /// Get country code from selected card or active locale
  String _getCountryFromCard() {
    // Try to get country from selected card
    if (widget.selectedCard.containsKey('countryCode')) {
      return widget.selectedCard['countryCode'] as String;
    }
    // Fall back to active locale country
    return serviceLocator<LocaleManager>().currentCountry;
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

  void _selectBank(String bankName, {bool fromBottomSheet = false}) {
    setState(() {
      _selectedBank = bankName;

    });
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
    for (var bank in _banks) {
      if (command.contains(bank['name'].toLowerCase())) {
        setState(() => _selectedBank = bank['name']);
        _speakResponse('Selected ${bank['name']}');
        break;
      }
    }
    final amountMatch = RegExp(r'\d+').firstMatch(command);
    if (amountMatch != null) {
      final amount = amountMatch.group(0);
      setState(() => _amountController.text = amount!);
      _speakResponse('Amount set to £$amount');
    }
  }

  Future<void> _speakResponse(String text) async {
    await _flutterTts.speak(text);
  }

  /// Refreshes the account balances - DISABLED: WebSocket handles real-time updates
  /// The ws-balance-service pushes balance updates to the Flutter app via WebSocket,
  /// which triggers the balance animation on the dashboard automatically.
  void _refreshAccountBalances(BuildContext context) {
    // REMOVED: Manual refresh is no longer needed - WebSocket handles balance updates
    // The dashboard will receive the update via BalanceWebSocketCubit and show animation
    print('Manual refresh skipped - WebSocket will handle balance update');
  }

  void _showAllBanksBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select Bank Account',
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
            Expanded(
              child: ListView.builder(
                itemCount: _banks.length,
                itemBuilder: (context, index) {
                  final bank = _banks[index];
                  final isSelected = _selectedBank == bank['name'];
                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        _selectBank(bank['name'], fromBottomSheet: true);
                        Navigator.pop(context);
                      },
                      borderRadius: BorderRadius.circular(12.r),
                      child: Container(
                        margin: EdgeInsets.only(bottom: 8.h),
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? bank['color'].withValues(alpha: 0.1)
                              : Colors.white.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: isSelected
                                ? bank['color']
                                : Colors.white.withValues(alpha: 0.1),
                            width: isSelected ? 2 : 1,
                          ),
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
                                  color:
                                      isSelected ? bank['color'] : Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get selected bank details with null safety
    Map<String, dynamic>? selectedBankDetails;
    if (_selectedBank.isNotEmpty) {
      try {
        selectedBankDetails = _banks.firstWhere(
          (bank) => bank['name'] == _selectedBank,
          orElse: () => {},
        );
      } catch (e) {
        selectedBankDetails = null;
      }
    }

    return BlocProvider(
      create: (_) => serviceLocator<WithdrawalCubit>(),
      child: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, authState) {
          if (authState is! AuthenticationSuccess) {
            Get.snackbar('Authentication Error', 'You need to be logged in to make a withdrawal.', 
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red.withValues(alpha: 0.7),
              colorText: Colors.white
            );
          }
        },
        builder: (authContext, authState) {
          return BlocConsumer<WithdrawalCubit, WithdrawalState>(
            listener: (context, state) {
              if (state is WithdrawalLoading) {
                setState(() => _isProcessing = true);
              } else {
                setState(() => _isProcessing = false);
              }

              if (state is WithdrawalSuccess) {
                Get.closeAllSnackbars();
                Get.snackbar(
                  'Withdrawal Successful',
                  'Your withdrawal of £${_amountController.text} has been processed successfully.',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.green.withValues(alpha: 0.9),
                  colorText: Colors.white,
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

                });

                // Refresh account balances
                _refreshAccountBalances(context);

                // Navigate back to dashboard after delay
                Future.delayed(const Duration(seconds: 2), () {
                  if (!mounted) return;
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                });
              } else if (state is WithdrawalFailure) {
                Get.closeAllSnackbars();
                Get.snackbar(
                  'Withdrawal Failed',
                  state.message,
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red.withValues(alpha: 0.9),
                  colorText: Colors.white,
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
              }
            },
            builder: (context, state) {
              return Scaffold(
                backgroundColor: const Color(0xFF1A1A1A),
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  title: Text(
                    'Withdraw Funds',
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
                  ],
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Balance Card
                        Container(
                          padding: EdgeInsets.all(24.w),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.selectedCard['accountType'] as String,
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.7),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
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
                              SizedBox(height: 8.h),
                              Text(
                                "£${widget.selectedCard['balance'].toStringAsFixed(2)}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 16.h),
                              Row(
                                children: [
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
                                      widget.selectedCard['accountNumber'] as String,
                                      style: TextStyle(
                                        color: Colors.white.withValues(alpha: 0.7),
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24.h),

                        // Voice Command Status
                        if (_isVoiceEnabled)
                          Container(
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
                                        : 'Voice commands enabled. Try saying "Select Barclays" or "Withdraw 500 pounds"',
                                    style: TextStyle(
                                      color: const Color(0xFF3498DB),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        SizedBox(height: 24.h),

                        // Bank Selection
                        Text(
                          'Withdraw to',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: _showAllBanksBottomSheet,
                            borderRadius: BorderRadius.circular(12.r),
                            child: Container(
                              padding: EdgeInsets.all(16.w),
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
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.account_balance,
                                    color: Colors.white.withValues(alpha: 0.7),
                                    size: 24.sp,
                                  ),
                                  SizedBox(width: 16.w),
                                  Expanded(
                                    child: Text(
                                      _selectedBank.isEmpty
                                          ? 'Select Bank Account'
                                          : _selectedBank,
                                      style: TextStyle(
                                        color: _selectedBank.isEmpty
                                            ? Colors.white.withValues(alpha: 0.5)
                                            : Colors.white,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white.withValues(alpha: 0.7),
                                    size: 16.sp,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Selected Bank Details Card
                        if (selectedBankDetails != null &&
                            selectedBankDetails.isNotEmpty) ...[
                          SizedBox(height: 24.h),
                          Container(
                            padding: EdgeInsets.all(20.w),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  (selectedBankDetails['color'] as Color)
                                      .withValues(alpha: 0.2),
                                  (selectedBankDetails['color'] as Color)
                                      .withValues(alpha: 0.1),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(16.r),
                              boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(8.w),
                                      decoration: BoxDecoration(
                                        color: (selectedBankDetails['color'] as Color)
                                            .withValues(alpha: 0.2),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        selectedBankDetails['icon'] as IconData,
                                        color: selectedBankDetails['color'] as Color,
                                        size: 24.sp,
                                      ),
                                    ),
                                    SizedBox(width: 16.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            selectedBankDetails['name'] as String,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(height: 4.h),
                                          Text(
                                            selectedBankDetails['accountType'] as String,
                                            style: TextStyle(
                                              color: Colors.white.withValues(alpha: 0.7),
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.h),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 12.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Account Number',
                                        style: TextStyle(
                                          color: Colors.white.withValues(alpha: 0.7),
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        selectedBankDetails['accountNumber'] as String,
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
                        ],
                        SizedBox(height: 32.h),

                        // Amount Input
                        Text(
                          'Amount',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Container(
                          padding: EdgeInsets.all(16.w),
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
                          child: Row(
                            children: [
                              Text(
                                '£',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 8.w),
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
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24.h),

                        // Quick Amounts
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildQuickAmountButton('£100'),
                            _buildQuickAmountButton('£500'),
                            _buildQuickAmountButton('£1000'),
                            _buildQuickAmountButton('£2000'),
                          ],
                        ),
                        SizedBox(height: 32.h),

                        // Withdraw Button - Always visible
                        _buildWithdrawButton(context),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildWithdrawButton(BuildContext context) {
    final amount = double.tryParse(_amountController.text) ?? 0;
    final balance = widget.selectedCard['balance'] as double? ?? 0.0;
    final exceedsBalance = amount > balance && amount > 0;
    final isValid = _selectedBank.isNotEmpty && amount > 0 && !exceedsBalance;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: isValid && !_isProcessing
            ? [
                BoxShadow(
                  color: const Color(0xFF3498DB).withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ]
            : [],
      ),
      child: Column(
        children: [
          if (exceedsBalance)
            Container(
              margin: EdgeInsets.only(bottom: 12.h),
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.red,
                    size: 20.sp,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'Amount exceeds available balance (£${balance.toStringAsFixed(2)})',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ElevatedButton(
            onPressed: !isValid || _isProcessing ? null : () => _handleWithdraw(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: isValid && !_isProcessing
                  ? const Color(0xFF3498DB)
                  : Colors.grey.shade700,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 18.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              elevation: 0,
              minimumSize: Size(double.infinity, 56.h),
            ),
            child: _isProcessing
                ? Row(
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
                        'Processing Withdrawal...',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Transform.rotate(
                        angle: -0.785398, // -45 degrees in radians (down-right arrow)
                        child: Icon(
                          Icons.arrow_downward_rounded,
                          size: 22.sp,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        amount > 0 ? 'Withdraw £${amount.toStringAsFixed(2)}' : 'Withdraw Funds',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAmountButton(String amount) {
    return GestureDetector(
      onTap: () {
        setState(() => _amountController.text = amount.replaceAll('£', ''));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(8.r),
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
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  void _handleWithdraw(BuildContext buildContext) {
    FocusScope.of(buildContext).unfocus();

    if (_selectedBank.isEmpty) {
      Get.snackbar('Error', 'Please select a target bank.', snackPosition: SnackPosition.BOTTOM);
      return;
    }
    final amount = double.tryParse(_amountController.text);
    if (amount == null || amount <= 0) {
      Get.snackbar('Error', 'Please enter a valid positive amount.', snackPosition: SnackPosition.BOTTOM);
      return;
    }

    int? sourceAccountId;
    try {
      if (widget.selectedCard['id'] is int) {
        sourceAccountId = widget.selectedCard['id'];
      } else if (widget.selectedCard['id'] is String) {
        sourceAccountId = int.tryParse(widget.selectedCard['id'] as String);
      }
    } catch (e) {
      print('Error parsing account ID: $e');
    }

    if (sourceAccountId == null) {
      Get.snackbar('Error', 'Invalid account information. Please try again.', snackPosition: SnackPosition.BOTTOM);
      return;
    }

    final currency = widget.selectedCard['currency'] as String? ?? 'GBP';
    
    final selectedBankInfo = _banks.firstWhere(
      (bank) => bank['name'] == _selectedBank,
      orElse: () => {},
    );
    
    if (selectedBankInfo.isEmpty) {
      Get.snackbar('Error', 'Bank information not found. Please select a different bank.', snackPosition: SnackPosition.BOTTOM);
      return;
    }
    
    final targetAccountNumber = selectedBankInfo['accountNumber'] as String;

    final authState = context.read<AuthenticationCubit>().state;
    String? accessToken;
    
    if (authState is AuthenticationSuccess) {
      accessToken = authState.profile.session.accessToken;
    } else {
      Get.snackbar('Authentication Error', 'You need to be logged in to make a withdrawal.', 
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.7),
        colorText: Colors.white
      );
      return;
    }

    buildContext.read<WithdrawalCubit>().initiateWithdrawal(
      sourceAccountId: sourceAccountId,
      amount: amount,
      currency: currency,
      targetBankName: _selectedBank,
      targetAccountNumber: targetAccountNumber,
      accessToken: accessToken,
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    _flutterTts.stop();
    _speech.cancel();
    super.dispose();
  }
} 