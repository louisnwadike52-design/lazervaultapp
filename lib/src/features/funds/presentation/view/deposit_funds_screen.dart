import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/funds/cubit/deposit_cubit.dart';
import 'package:lazervault/src/features/funds/cubit/deposit_state.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';

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

  final List<Map<String, dynamic>> _banks = [
    {'name': 'Barclays', 'icon': Icons.account_balance, 'color': Colors.blue},
    {'name': 'HSBC UK', 'icon': Icons.account_balance, 'color': Colors.red},
    {'name': 'NatWest', 'icon': Icons.account_balance, 'color': Colors.green},
    {'name': 'Lloyds Bank', 'icon': Icons.account_balance, 'color': Colors.orange},
    {'name': 'Santander UK', 'icon': Icons.account_balance, 'color': Colors.purple},
    {'name': 'Royal Bank of Scotland', 'icon': Icons.account_balance, 'color': Colors.teal},
    {'name': 'Standard Chartered', 'icon': Icons.account_balance, 'color': Colors.indigo},
    {'name': 'Metro Bank', 'icon': Icons.account_balance, 'color': Colors.pink},
  ];

  List<Map<String, dynamic>> get _displayedBanks {
    if (_selectedBank.isEmpty) return _banks.take(4).toList();
    if (!_wasSelectedFromBottomSheet) {
      return _banks.take(4).toList();
    }
    final selectedBankData = _banks.firstWhere((bank) => bank['name'] == _selectedBank, orElse: () => {});
    if (selectedBankData.isEmpty) return _banks.take(4).toList();

    final List<Map<String, dynamic>> reorderedBanks = [selectedBankData];
    reorderedBanks.addAll(_banks.where((bank) => bank['name'] != _selectedBank).take(3));
    return reorderedBanks;
  }

  @override
  void initState() {
    super.initState();
    _initializeSpeech();
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
      _speakResponse('Amount set to £$amount');
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
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'All UK Banks',
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
                      borderRadius: BorderRadius.circular(16.r),
                      child: Container(
                        margin: EdgeInsets.only(bottom: 12.h),
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? bank['color'].withOpacity(0.1)
                              : Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: isSelected
                                ? bank['color']
                                : Colors.white.withOpacity(0.1),
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                color: bank['color'].withOpacity(0.1),
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<DepositCubit>()),
        // Create a new instance of AccountCardsSummaryCubit to use for refreshing account data
        BlocProvider(create: (_) => serviceLocator<AccountCardsSummaryCubit>()),
      ],
      child: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, authState) {
          if (authState is! AuthenticationSuccess) {
            Get.snackbar('Authentication Error', 'You need to be logged in to make a deposit.', 
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red.withOpacity(0.7),
              colorText: Colors.white
            );
          }
        },
        builder: (authContext, authState) {
          return Scaffold(
            backgroundColor: const Color(0xFF1A1A1A),
            appBar: _buildAppBar(),
            body: BlocConsumer<DepositCubit, DepositState>(
              listener: _blocListener,
              builder: (context, state) {
                final isLoading = state is DepositLoading;
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSelectedCardSummary(),
                        SizedBox(height: 24.h),
                        if (_isVoiceEnabled) _buildVoiceCommandStatus(),
                        if (_isVoiceEnabled) SizedBox(height: 24.h),
                        _buildBankSelectionHeader(),
                        SizedBox(height: 16.h),
                        _buildBankSelectionGrid(isLoading),
                        SizedBox(height: 24.h),
                        _buildAmountInput(isLoading),
                        SizedBox(height: 24.h),
                        _buildQuickAmounts(isLoading),
                        SizedBox(height: 32.h),
                        _buildDepositButton(context, isLoading),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
  
  void _blocListener(BuildContext context, DepositState state) {
    if (state is DepositFailure) {
      Get.closeAllSnackbars(); // Close any existing snackbars
      Get.snackbar(
        'Deposit Failed',
        state.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
        isDismissible: true,
        duration: const Duration(seconds: 5),
        margin: EdgeInsets.all(16.w),
        borderRadius: 8.r,
        icon: Icon(
          Icons.error_outline,
          color: Colors.white,
          size: 28.sp,
        ),
      );
    } else if (state is DepositSuccess) {
      Get.closeAllSnackbars(); // Close any existing snackbars
      Get.snackbar(
        'Deposit Successful',
        'Your deposit of £${_amountController.text} from $_selectedBank has been received. Transaction ID: ${state.depositDetails.depositId}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
        isDismissible: true,
        duration: const Duration(seconds: 5),
        margin: EdgeInsets.all(16.w),
        borderRadius: 8.r,
        icon: Icon(
          Icons.check_circle,
          color: Colors.white,
          size: 28.sp,
        ),
      );
      _amountController.clear();
      setState(() {
        _selectedBank = '';
        _wasSelectedFromBottomSheet = false;
      });
      
      // Refresh account balances on both screens
      _refreshAccountBalances(context);
      
      // Navigate back to previous screen after a short delay
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).pop();
      });
    }
  }
  
  /// Refreshes the account balances - will update both the local and dashboard screens
  void _refreshAccountBalances(BuildContext context) {
    try {
      // Get the current authentication state to retrieve user info
      final authState = context.read<AuthenticationCubit>().state;
      if (authState is AuthenticationSuccess) {
        final userId = authState.profile.user.id;
        final accessToken = authState.profile.session.accessToken;
        
        print('Refreshing account summaries after successful deposit');
        
        // First, refresh the locally created AccountCardsSummaryCubit
        // This ensures we have fresh data if needed on this screen
        try {
          // Only try to access the cubit if it's available (we're in the MultiBlocProvider context)
          if (context.mounted) {
            try {
              // Safe access to the cubit
              final localCubit = BlocProvider.of<AccountCardsSummaryCubit>(context, listen: false);
              localCubit.fetchAccountSummaries(
                userId: userId,
                accessToken: accessToken,
              );
              print('Successfully refreshed local AccountCardsSummaryCubit');
            } catch (e) {
              // This will catch the case where the cubit isn't available
              print('Local AccountCardsSummaryCubit not found: $e');
            }
          }
        } catch (e) {
          print('Error refreshing local cubit: $e');
        }
        
        // Since AccountCardsSummaryCubit is now a singleton, this will update 
        // the data used by all screens that use it
        try {
          final dashboardCubit = serviceLocator<AccountCardsSummaryCubit>();
          dashboardCubit.fetchAccountSummaries(
            userId: userId,
            accessToken: accessToken,
          );
          print('Successfully refreshed AccountCardsSummaryCubit singleton instance');
        } catch (e) {
          print('Error refreshing singleton cubit instance: $e');
        }
      }
    } catch (e) {
      print('Error refreshing account balances: $e');
    }
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
            color: Colors.black.withOpacity(0.15),
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
                  color: Colors.white.withOpacity(0.1),
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
            "£${widget.selectedCard['balance'].toStringAsFixed(2)}",
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
                      ? Colors.green.withOpacity(0.2)
                      : Colors.red.withOpacity(0.2),
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
        color: const Color(0xFF3498DB).withOpacity(0.1),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFF3498DB),
        ),
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
          'Select UK Bank',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF3498DB).withOpacity(0.1),
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
                    ? bank['color'].withOpacity(0.2)
                    : Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: isSelected
                      ? bank['color']
                      : Colors.white.withOpacity(0.1),
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: bank['color'].withOpacity(0.2),
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
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 8.h,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  '£',
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
                      color: Colors.white.withOpacity(0.3),
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
            _buildQuickAmountButton('£100', isLoading),
            _buildQuickAmountButton('£500', isLoading),
            _buildQuickAmountButton('£1000', isLoading),
            _buildQuickAmountButton('£2000', isLoading),
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
          setState(() => _amountController.text = amount.replaceAll('£', ''));
        },
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          child: Text(
            amount,
            style: TextStyle(
              color: isLoading ? Colors.white.withOpacity(0.3) : Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDepositButton(BuildContext buildContext, bool isLoading) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16.h),
      child: ElevatedButton(
        onPressed:
            _selectedBank.isEmpty || _amountController.text.isEmpty || isLoading
                ? null
                : () => _handleDeposit(buildContext),
        style: ElevatedButton.styleFrom(
          backgroundColor: isLoading ? Colors.grey : Colors.green,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20.h,
                    width: 20.w,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'Processing...',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
            : Text(
                'Proceed with Deposit',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
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

    int? targetAccountId;
    try {
      if (widget.selectedCard['id'] is int) {
        targetAccountId = widget.selectedCard['id'];
      } else if (widget.selectedCard['id'] is String) {
        targetAccountId = int.tryParse(widget.selectedCard['id'] as String);
      }
    } catch (e) {
      print('Error parsing account ID: $e');
    }

    if (targetAccountId == null) {
      Get.snackbar('Error', 'Invalid account information. Please try again.', snackPosition: SnackPosition.BOTTOM);
      return;
    }

    final currency = widget.selectedCard['currency'] as String? ?? 'GBP';

    final authState = context.read<AuthenticationCubit>().state;
    String? accessToken;
    
    if (authState is AuthenticationSuccess) {
      accessToken = authState.profile.session.accessToken;
    } else {
      Get.snackbar('Authentication Error', 'You need to be logged in to make a deposit.', 
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.7),
        colorText: Colors.white
      );
      return;
    }

    buildContext.read<DepositCubit>().initiateDeposit(
      targetAccountId: targetAccountId,
      amount: amount,
      currency: currency,
      sourceBankName: _selectedBank,
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
    _amountController.dispose();
    _flutterTts.stop();
    _speech.cancel();
    super.dispose();
  }
}
