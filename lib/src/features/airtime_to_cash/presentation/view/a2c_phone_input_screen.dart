import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/network_rate.dart';
import '../cubit/airtime_to_cash_cubit.dart';
import '../cubit/airtime_to_cash_state.dart';
import '../widgets/a2c_step_indicator.dart';

/// Consolidated A2C details screen: phone number + amount input in one step.
class A2CPhoneInputScreen extends StatefulWidget {
  const A2CPhoneInputScreen({super.key});

  @override
  State<A2CPhoneInputScreen> createState() => _A2CPhoneInputScreenState();
}

class _A2CPhoneInputScreenState extends State<A2CPhoneInputScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _amountFocusNode = FocusNode();

  String? selectedNetwork;
  NetworkRate? selectedRate;
  String? detectedNetwork;
  bool isPhoneValid = false;
  double? selectedAmount;

  final List<double> quickAmounts = [500, 1000, 2000, 5000, 10000];

  @override
  void initState() {
    super.initState();
    _loadArguments();
    _phoneController.addListener(_onPhoneChanged);
  }

  void _loadArguments() {
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      selectedNetwork = args['network'] as String?;
      selectedRate = args['rate'] as NetworkRate?;
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _amountController.dispose();
    _phoneFocusNode.dispose();
    _amountFocusNode.dispose();
    super.dispose();
  }

  void _onPhoneChanged() {
    if (!mounted) return;
    final phone = _phoneController.text;

    final newIsValid = phone.length == 11 && phone.startsWith('0');
    if (newIsValid != isPhoneValid) {
      setState(() {
        isPhoneValid = newIsValid;
      });
    }

    // Auto-detect network from prefix
    if (phone.length >= 4) {
      final detected = _detectNetworkFromPrefix(phone);
      if (detected != null && detected != detectedNetwork) {
        final oldDetected = detectedNetwork;
        setState(() {
          detectedNetwork = detected;
        });
        // Notify user if detected network differs from selected
        if (selectedNetwork != null &&
            detected.toLowerCase() != selectedNetwork!.toLowerCase() &&
            oldDetected != detected) {
          _showNetworkUpdatedDialog(detected);
        }
      }
    } else {
      if (detectedNetwork != null) {
        setState(() {
          detectedNetwork = null;
        });
      }
    }
  }

  String? _detectNetworkFromPrefix(String phone) {
    if (phone.length < 4) return null;
    final prefix = phone.substring(0, 4);

    const mtnPrefixes = [
      '0803', '0806', '0810', '0813', '0814', '0816',
      '0903', '0906', '0913', '0916', '0703', '0706',
    ];
    const airtelPrefixes = [
      '0802', '0808', '0812', '0701', '0708',
      '0901', '0902', '0904', '0907', '0912',
    ];
    const gloPrefixes = [
      '0805', '0807', '0811', '0815',
      '0905', '0915', '0705',
    ];
    const nineMobilePrefixes = [
      '0809', '0817', '0818', '0908', '0909',
    ];

    if (mtnPrefixes.contains(prefix)) return 'mtn';
    if (airtelPrefixes.contains(prefix)) return 'airtel';
    if (gloPrefixes.contains(prefix)) return 'glo';
    if (nineMobilePrefixes.contains(prefix)) return '9mobile';
    return null;
  }

  void _showNetworkUpdatedDialog(String detected) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Row(
          children: [
            Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: const Color(0xFFFB923C).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                Icons.swap_horiz,
                color: const Color(0xFFFB923C),
                size: 20.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                'Network Mismatch',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        content: Text(
          'The phone number you entered belongs to ${detected.toUpperCase()}, not ${selectedNetwork?.toUpperCase()}. The network will be updated to ${detected.toUpperCase()} for this conversion.',
          style: TextStyle(
            fontSize: 14.sp,
            color: const Color(0xFF9CA3AF),
            height: 1.5,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'OK',
              style: TextStyle(
                color: const Color(0xFF3B82F6),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _selectAmount(double amount) {
    setState(() {
      selectedAmount = amount;
      _amountController.text = amount.toStringAsFixed(0);
    });
  }

  bool get _isAmountValid {
    if (selectedAmount == null) return false;
    if (selectedRate != null) {
      return selectedRate!.isAmountValid(selectedAmount!);
    }
    return selectedAmount! >= 100 && selectedAmount! <= 50000;
  }

  double get _estimatedCash {
    if (selectedAmount == null || selectedRate == null) return 0;
    return selectedRate!.estimateCash(selectedAmount!);
  }

  bool get _canProceed => isPhoneValid && _isAmountValid;

  void _validateAndProceed() {
    final phone = _phoneController.text.trim();

    if (phone.isEmpty) {
      _showError('Please enter a phone number');
      return;
    }
    if (phone.length != 11) {
      _showError('Phone number must be 11 digits');
      return;
    }
    if (!phone.startsWith('0')) {
      _showError('Phone number must start with 0');
      return;
    }
    if (selectedAmount == null) {
      _showError('Please enter an amount');
      return;
    }
    if (selectedRate == null) {
      _showError('Conversion rate not available. Please go back and select a network.');
      return;
    }

    if (!selectedRate!.isAmountValid(selectedAmount!)) {
      _showError(
          'Amount must be between ${selectedRate!.formattedMinAmount} and ${selectedRate!.formattedMaxAmount}');
      return;
    }

    final network = detectedNetwork ?? selectedNetwork;
    if (network == null) {
      _showError('Could not detect network. Please go back and select manually.');
      return;
    }

    context.read<AirtimeToCashCubit>().prepareReview(
          phoneNumber: phone,
          network: network,
          amount: selectedAmount!,
          rate: selectedRate!,
        );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFFEF4444),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: BlocListener<AirtimeToCashCubit, AirtimeToCashState>(
          listener: (context, state) {
            if (state is AirtimeToCashReviewReady) {
              Get.toNamed(AppRoutes.airtimeToCashReview, arguments: {
                'phoneNumber': state.phoneNumber,
                'network': state.network,
                'amount': state.amount,
                'rate': state.rate,
                'estimatedCash': state.estimatedCash,
              });
            } else if (state is AirtimeToCashError) {
              _showError(state.message);
            }
          },
          child: Column(
            children: [
              _buildHeader(),
              const A2CStepIndicator(currentStep: 1),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),

                      // Selected network card
                      if (selectedNetwork != null) _buildSelectedNetworkCard(),

                      SizedBox(height: 24.h),

                      // Phone number input
                      _buildPhoneNumberInput(),

                      SizedBox(height: 16.h),

                      // Detected network indicator
                      if (detectedNetwork != null)
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: _buildDetectedNetworkBanner(),
                        ),

                      SizedBox(height: 24.h),

                      // Amount input section
                      _buildAmountInput(),

                      SizedBox(height: 24.h),

                      // Quick amount buttons
                      _buildQuickAmounts(),

                      SizedBox(height: 24.h),

                      // Conversion calculator
                      if (selectedAmount != null && selectedRate != null)
                        _buildConversionCalculator(),

                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ),
              _buildContinueButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(12.r),
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
                  'Conversion Details',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Enter your phone number and amount',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Get.until((route) => route.settings.name == AppRoutes.airtimeToCash || route.isFirst),
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.close,
                color: const Color(0xFF9CA3AF),
                size: 20.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedNetworkCard() {
    final Color networkColor = _getNetworkColor(selectedNetwork!);

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: networkColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(
              child: Text(
                selectedNetwork!.substring(0, 1).toUpperCase(),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
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
                  'Selected Network',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
                Text(
                  selectedNetwork!.toUpperCase(),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          if (selectedRate != null)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: const Color(0xFF10B981).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                '${selectedRate!.ratePercentage} rate',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF10B981),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPhoneNumberInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Phone Number',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: TextField(
            controller: _phoneController,
            focusNode: _phoneFocusNode,
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(11),
            ],
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: '08012345678',
              hintStyle: TextStyle(
                color: const Color(0xFF9CA3AF).withValues(alpha: 0.5),
                fontSize: 16.sp,
              ),
              prefixIcon: Container(
                padding: EdgeInsets.all(12.w),
                child: Text(
                  '+234',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: const Color(0xFF9CA3AF),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              suffixIcon: isPhoneValid
                  ? Icon(
                      Icons.check_circle,
                      color: const Color(0xFF10B981),
                      size: 22.sp,
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.info_outline,
                color: const Color(0xFF3B82F6),
                size: 16.sp,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'An OTP from the provider will be sent to this number to verify ownership.',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFF9CA3AF),
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetectedNetworkBanner() {
    final Color networkColor = _getNetworkColor(detectedNetwork!);
    final bool isMismatch = selectedNetwork != null &&
        detectedNetwork!.toLowerCase() != selectedNetwork!.toLowerCase();

    return Container(
      key: ValueKey(detectedNetwork),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: isMismatch
            ? const Color(0xFFFB923C).withValues(alpha: 0.1)
            : networkColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isMismatch
              ? const Color(0xFFFB923C).withValues(alpha: 0.3)
              : networkColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            isMismatch ? Icons.warning_amber_rounded : Icons.check_circle,
            color: isMismatch ? const Color(0xFFFB923C) : const Color(0xFF10B981),
            size: 20.sp,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              isMismatch
                  ? 'Number belongs to ${detectedNetwork!.toUpperCase()} — will use ${detectedNetwork!.toUpperCase()}'
                  : 'Detected: ${detectedNetwork!.toUpperCase()} network',
              style: TextStyle(
                fontSize: 13.sp,
                color: isMismatch
                    ? const Color(0xFFFB923C)
                    : const Color(0xFF10B981),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Airtime Amount',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: _amountController,
            focusNode: _amountFocusNode,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(6),
            ],
            onChanged: (value) {
              if (value.isNotEmpty) {
                final amount = double.tryParse(value);
                if (amount != null) {
                  setState(() {
                    selectedAmount = amount;
                  });
                }
              } else {
                setState(() {
                  selectedAmount = null;
                });
              }
            },
            style: TextStyle(
              fontSize: 24.sp,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            decoration: InputDecoration(
              hintText: '0',
              hintStyle: TextStyle(
                color: Colors.white.withValues(alpha: 0.4),
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
              prefixIcon: Container(
                padding: EdgeInsets.all(16.w),
                child: Text(
                  '\u20A6',
                  style: TextStyle(
                    fontSize: 24.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 20.h,
              ),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        if (selectedRate != null)
          Text(
            'Min: ${selectedRate!.formattedMinAmount}  \u2022  Max: ${selectedRate!.formattedMaxAmount}',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.white.withValues(alpha: 0.5),
              fontWeight: FontWeight.w400,
            ),
          ),
      ],
    );
  }

  Widget _buildQuickAmounts() {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: quickAmounts.map((amount) {
        final isSelected = selectedAmount == amount;
        final isWithinRange =
            selectedRate == null || selectedRate!.isAmountValid(amount);

        return GestureDetector(
          onTap: isWithinRange ? () => _selectAmount(amount) : null,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFF3B82F6)
                  : const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              '\u20A6${amount.toStringAsFixed(0)}',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? Colors.white
                    : isWithinRange
                        ? Colors.white.withValues(alpha: 0.8)
                        : const Color(0xFF9CA3AF).withValues(alpha: 0.5),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildConversionCalculator() {
    final cashAmount = _estimatedCash;
    final isValid = _isAmountValid;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isValid
              ? const Color(0xFF10B981).withValues(alpha: 0.3)
              : const Color(0xFF2D2D2D),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.calculate_outlined, color: const Color(0xFF3B82F6), size: 20.sp),
              SizedBox(width: 8.w),
              Text(
                'Conversion Estimate',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildCalcRow('You send', '\u20A6${selectedAmount!.toStringAsFixed(0)}',
              Icons.arrow_upward, const Color(0xFFEF4444)),
          SizedBox(height: 12.h),
          _buildCalcRow('Rate', selectedRate!.ratePercentage,
              Icons.percent, const Color(0xFF3B82F6)),
          if (selectedRate!.automationFee > 0) ...[
            SizedBox(height: 12.h),
            _buildCalcRow('Fee', selectedRate!.formattedFee,
                Icons.receipt_long, const Color(0xFFFB923C)),
          ],
          SizedBox(height: 12.h),
          const Divider(color: Color(0xFF2D2D2D)),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 28.w, height: 28.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(7.r),
                    ),
                    child: Icon(Icons.arrow_downward, color: const Color(0xFF10B981), size: 16.sp),
                  ),
                  SizedBox(width: 10.w),
                  Text('You get', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.white)),
                ],
              ),
              Text(
                '\u20A6${cashAmount.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700, color: const Color(0xFF10B981)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCalcRow(String label, String value, IconData icon, Color iconColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 28.w, height: 28.w,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(7.r),
              ),
              child: Icon(icon, color: iconColor, size: 16.sp),
            ),
            SizedBox(width: 10.w),
            Text(label, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.white.withValues(alpha: 0.6))),
          ],
        ),
        Text(value, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.white.withValues(alpha: 0.8))),
      ],
    );
  }

  Widget _buildContinueButton() {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _canProceed ? _validateAndProceed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: _canProceed
                ? const Color(0xFF3B82F6)
                : const Color(0xFF1F1F1F),
            padding: EdgeInsets.symmetric(vertical: 16.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.r),
            ),
            elevation: 0,
          ),
          child: Text(
            'Continue to Review',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: _canProceed ? Colors.white : const Color(0xFF9CA3AF),
            ),
          ),
        ),
      ),
    );
  }

  Color _getNetworkColor(String network) {
    switch (network.toLowerCase()) {
      case 'mtn':
        return const Color(0xFFFFCC00);
      case 'airtel':
        return const Color(0xFFEF4444);
      case 'glo':
        return const Color(0xFF10B981);
      case '9mobile':
        return const Color(0xFF00A651);
      default:
        return const Color(0xFF3B82F6);
    }
  }
}
