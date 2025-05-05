import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/domain/entities/user.dart';

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
  // final FlutterTts _flutterTts = FlutterTts();
  // final stt.SpeechToText _speech = stt.SpeechToText();
  String _selectedBank = '';
  bool _isProcessing = false;
  // bool _isListening = false;
  // String _recognizedText = '';
  bool _isVoiceEnabled = false;

  final List<Map<String, dynamic>> _banks = [
    {'name': 'Barclays', 'icon': Icons.account_balance, 'color': Colors.blue},
    {'name': 'HSBC UK', 'icon': Icons.account_balance, 'color': Colors.red},
    {'name': 'NatWest', 'icon': Icons.account_balance, 'color': Colors.green},
    {
      'name': 'Lloyds Bank',
      'icon': Icons.account_balance,
      'color': Colors.orange
    },
    {
      'name': 'Santander UK',
      'icon': Icons.account_balance,
      'color': Colors.purple
    },
    {
      'name': 'Royal Bank of Scotland',
      'icon': Icons.account_balance,
      'color': Colors.teal
    },
    {
      'name': 'Standard Chartered',
      'icon': Icons.account_balance,
      'color': Colors.indigo
    },
    {'name': 'Metro Bank', 'icon': Icons.account_balance, 'color': Colors.pink},
  ];

  List<Map<String, dynamic>> get _displayedBanks {
    if (_selectedBank.isEmpty) return _banks.take(4).toList();

    // If bank was selected from grid, return original order
    if (!_wasSelectedFromBottomSheet) {
      return _banks.take(4).toList();
    }

    // If bank was selected from bottom sheet, put it first
    final selectedBank =
        _banks.firstWhere((bank) => bank['name'] == _selectedBank);
    final List<Map<String, dynamic>> reorderedBanks = [selectedBank];
    reorderedBanks
        .addAll(_banks.where((bank) => bank['name'] != _selectedBank).take(3));
    return reorderedBanks;
  }

  bool _wasSelectedFromBottomSheet = false;

  void _selectBank(String bankName, {bool fromBottomSheet = false}) {
    setState(() {
      _selectedBank = bankName;
      _wasSelectedFromBottomSheet = fromBottomSheet;
      if (fromBottomSheet) {
        // Move the selected bank to the first position in the main list
        final bankIndex = _banks.indexWhere((bank) => bank['name'] == bankName);
        if (bankIndex != -1) {
          final selectedBank = _banks.removeAt(bankIndex);
          _banks.insert(0, selectedBank);
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // _initializeSpeech();
  }

  /*
  Future<void> _initializeSpeech() async {
    await _speech.initialize();
    await _flutterTts.setLanguage('en-GB');
    await _flutterTts.setPitch(1.0);
  }
  */

  /*
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
  */

  /*
  void _stopListening() {
    _speech.stop();
    setState(() => _isListening = false);
  }
  */

  /*
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
  */

  /*
  Future<void> _speakResponse(String text) async {
    await _flutterTts.speak(text);
  }
  */

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
              color: _isVoiceEnabled ? Colors.grey : Colors.white,
            ),
            tooltip: 'Toggle Voice Commands (Disabled)',
            onPressed: () {
              setState(() {
                _isVoiceEnabled = !_isVoiceEnabled;
                if (_isVoiceEnabled) {
                  Get.snackbar('Info', 'Voice commands are currently disabled.', snackPosition: SnackPosition.BOTTOM);
                }
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Selected Card Summary
            Container(
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
            ),
            SizedBox(height: 24.h),

            // Voice Command Status
            if (_isVoiceEnabled)
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.mic_off,
                      color: Colors.grey,
                      size: 24.sp,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        'Voice commands are currently disabled.',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(height: 24.h),

            // Bank Selection Header
            Row(
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
            ),
            SizedBox(height: 16.h),

            // Bank Selection Grid with smaller cards and bigger text
            GridView.builder(
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
                    onTap: () => _selectBank(bank['name']),
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
            ),
            SizedBox(height: 24.h),

            // Amount Input
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
              padding: EdgeInsets.all(16.w),
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
                        fontSize: 20.sp,
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
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            // Quick Amounts
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
                _buildQuickAmountButton('£100'),
                _buildQuickAmountButton('£500'),
                _buildQuickAmountButton('£1000'),
                _buildQuickAmountButton('£2000'),
              ],
            ),
            SizedBox(height: 32.h),

            // Deposit Button
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 16.h),
              child: ElevatedButton(
                onPressed:
                    _selectedBank.isEmpty || _amountController.text.isEmpty
                        ? null
                        : _handleDeposit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
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
                    : Text(
                        'Proceed with Deposit',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAmountButton(String amount) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
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
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  void _handleDeposit() async {
    setState(() => _isProcessing = true);

    try {
      // Simulate API call to process deposit
      await Future.delayed(const Duration(seconds: 2));

      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Deposit of £${_amountController.text} to $_selectedBank initiated successfully',
              style: TextStyle(fontSize: 14.sp),
            ),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate to send funds screen with the selected bank details
        Get.toNamed(
          AppRoutes.sendFunds,
          arguments: {
            'recipient': {
              'name': _selectedBank,
              'accountNumber': widget.selectedCard['accountNumber'],
              'sortCode': "123456", // You might want to get this from somewhere
              'bank': _selectedBank,
              'isFavorite': false,
            } as User,
          },
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to process deposit. Please try again.',
              style: TextStyle(fontSize: 14.sp),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    // _flutterTts.stop();
    // _speech.cancel();
    super.dispose();
  }
}
