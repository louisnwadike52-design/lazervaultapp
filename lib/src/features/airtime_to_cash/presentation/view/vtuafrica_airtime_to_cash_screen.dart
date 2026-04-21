import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../cubit/airtime_to_cash_cubit.dart';
import '../cubit/airtime_to_cash_state.dart';

/// VTU Africa airtime-to-cash input screen.
/// Flow: Verify service → Get destination number → Transfer airtime → Confirm via webhook
class VtuafricaAirtimeToCashScreen extends StatefulWidget {
  const VtuafricaAirtimeToCashScreen({super.key});

  @override
  State<VtuafricaAirtimeToCashScreen> createState() =>
      _VtuafricaAirtimeToCashScreenState();
}

class _VtuafricaAirtimeToCashScreenState
    extends State<VtuafricaAirtimeToCashScreen> {
  final _phoneController = TextEditingController();
  final _amountController = TextEditingController();
  final _phoneFocusNode = FocusNode();
  final _amountFocusNode = FocusNode();

  String? _selectedNetwork;
  bool _phoneValid = false;
  String? _detectedNetwork;
  double? _amount;

  // VTU Africa rates (will be updated from backend)
  static const _networkRates = {
    'mtn': 0.84,
    'airtel': 0.85,
    'glo': 0.80,
    '9mobile': 0.79,
  };

  static const _networkOrder = ['mtn', 'airtel', 'glo', '9mobile'];

  static const _quickAmounts = [500.0, 1000.0, 2000.0, 5000.0, 10000.0];

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_onPhoneChanged);
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
    final valid = phone.length == 11 && phone.startsWith('0');
    if (valid != _phoneValid) {
      setState(() => _phoneValid = valid);
    }

    if (phone.length >= 4) {
      final detected = _detectNetworkFromPrefix(phone);
      if (detected != _detectedNetwork) {
        setState(() => _detectedNetwork = detected);
        if (detected != null) {
          setState(() => _selectedNetwork = detected);
        }
      }
    } else if (_detectedNetwork != null) {
      setState(() => _detectedNetwork = null);
    }
  }

  String? _detectNetworkFromPrefix(String phone) {
    if (phone.length < 4) return null;
    final p = phone.substring(0, 4);
    const mtn = [
      '0803', '0806', '0810', '0813', '0814', '0816', '0903',
      '0906', '0913', '0916', '0703', '0706'
    ];
    const airtel = [
      '0802', '0808', '0812', '0701', '0708', '0901',
      '0902', '0904', '0907', '0912'
    ];
    const glo = ['0805', '0807', '0811', '0815', '0905', '0915', '0705'];
    const mobile9 = ['0809', '0817', '0818', '0908', '0909'];
    if (mtn.contains(p)) return 'mtn';
    if (airtel.contains(p)) return 'airtel';
    if (glo.contains(p)) return 'glo';
    if (mobile9.contains(p)) return '9mobile';
    return null;
  }

  bool get _canProceed =>
      _phoneValid && _amount != null && _selectedNetwork != null;

  double get _estimatedCash {
    if (_amount == null || _selectedNetwork == null) return 0;
    final rate = _networkRates[_selectedNetwork!] ?? 0.8;
    return _amount! * rate;
  }

  void _verifyService() {
    if (!_canProceed) return;
    final phone = _phoneController.text.trim();
    final network = _selectedNetwork!;
    final amount = _amount!;

    context.read<AirtimeToCashCubit>().verifyVtuafricaService(
      phoneNumber: phone,
      network: network,
      amount: amount,
    );
  }

  Color _networkColor(String network) {
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
        return const Color(0xFF4E03D0);
    }
  }

  String _networkLabel(String network) {
    switch (network.toLowerCase()) {
      case 'mtn':
        return 'MTN';
      case 'airtel':
        return 'Airtel';
      case 'glo':
        return 'Glo';
      case '9mobile':
        return '9Mobile';
      default:
        return network.toUpperCase();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AirtimeToCashCubit, AirtimeToCashState>(
      listener: (context, state) {
        if (state is AirtimeToCashServiceVerified) {
          // Service verified - navigate to transfer screen
          Get.toNamed('/airtime-to-cash/vtuafrica/transfer', arguments: {
            'phoneNumber': _phoneController.text.trim(),
            'network': _selectedNetwork,
            'amount': _amount,
            'destinationPhone': state.destinationPhone,
            'providerRate': _networkRates[_selectedNetwork!] ?? 0.8,
          });
        } else if (state is AirtimeToCashError) {
          Get.snackbar(
            'Service Unavailable',
            state.message,
            backgroundColor: const Color(0xFFEF4444),
            colorText: Colors.white,
          );
        }
      },
      child: Scaffold(
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
                      SizedBox(height: 16.h),
                      _buildVtuafricaBanner(),
                      SizedBox(height: 20.h),
                      _buildNetworkSelection(),
                      SizedBox(height: 20.h),
                      _buildPhoneInput(),
                      SizedBox(height: 16.h),
                      _buildAmountInput(),
                      SizedBox(height: 12.h),
                      _buildQuickAmounts(),
                      SizedBox(height: 16.h),
                      if (_amount != null && _selectedNetwork != null)
                        _buildConversionPreview(),
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
                color: Colors.white.withValues(alpha: 0.1),
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
                  'Airtime to Cash',
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Transfer & Confirm',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.white.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVtuafricaBanner() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4E03D0), Color(0xFF4E03D0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(Icons.phone_in_talk, color: Colors.white, size: 22.sp),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Better rates on large amounts',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Transfer airtime, get confirmed via webhook',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNetworkSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Network',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          children: _networkOrder.map((network) {
            final isSelected = _selectedNetwork == network;
            final color = _networkColor(network);
            return Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _selectedNetwork = network),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: EdgeInsets.only(right: network != '9mobile' ? 8.w : 0),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? color.withValues(alpha: 0.2)
                        : const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: isSelected ? color : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        _networkLabel(network),
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color: isSelected ? color : Colors.white,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '${((_networkRates[network] ?? 0.8) * 100).toStringAsFixed(0)}%',
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: isSelected
                              ? color
                              : const Color(0xFF10B981),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPhoneInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Phone Number',
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
            style: TextStyle(fontSize: 16.sp, color: Colors.white),
            decoration: InputDecoration(
              hintText: '08012345678',
              hintStyle: TextStyle(
                color: const Color(0xFF9CA3AF).withValues(alpha: 0.5),
                fontSize: 16.sp,
              ),
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
                child: Text(
                  '+234',
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: const Color(0xFF9CA3AF),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              prefixIconConstraints: const BoxConstraints(),
              suffixIcon: _phoneValid
                  ? Icon(Icons.check_circle, color: const Color(0xFF10B981), size: 20.sp)
                  : null,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            ),
          ),
        ),
        if (_detectedNetwork != null) ...[
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: _networkColor(_detectedNetwork!).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle, color: const Color(0xFF10B981), size: 14.sp),
                SizedBox(width: 6.w),
                Text(
                  'Detected: ${_networkLabel(_detectedNetwork!)}',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFF10B981),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildAmountInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Airtime Amount',
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
            controller: _amountController,
            focusNode: _amountFocusNode,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(6),
            ],
            onChanged: (v) {
              setState(() {
                _amount = v.isNotEmpty ? double.tryParse(v) : null;
              });
            },
            style: TextStyle(
              fontSize: 22.sp,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            decoration: InputDecoration(
              hintText: '0',
              hintStyle: TextStyle(
                color: Colors.white.withValues(alpha: 0.4),
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
              ),
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
                child: Text(
                  '₦',
                  style: TextStyle(
                    fontSize: 22.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              prefixIconConstraints: const BoxConstraints(),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickAmounts() {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: _quickAmounts.map((amt) {
        final isSelected = _amount == amt;
        return GestureDetector(
          onTap: () {
            setState(() => _amount = amt);
            _amountController.text = amt.toStringAsFixed(0);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF4E03D0) : const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              '₦${amt.toStringAsFixed(0)}',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.8),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildConversionPreview() {
    final cash = _estimatedCash;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: const Color(0xFF4E03D0).withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('You send',
                  style: TextStyle(fontSize: 13.sp, color: const Color(0xFF9CA3AF))),
              Text('₦${_amount!.toStringAsFixed(0)}',
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Rate',
                  style: TextStyle(fontSize: 13.sp, color: const Color(0xFF9CA3AF))),
              Text(
                '${((_networkRates[_selectedNetwork!] ?? 0.8) * 100).toStringAsFixed(0)}%',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF4E03D0)),
              ),
            ],
          ),
          Divider(color: Colors.white.withValues(alpha: 0.08), height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('You get (estimated)',
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
              Text(
                '₦${cash.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF10B981),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton() {
    return BlocBuilder<AirtimeToCashCubit, AirtimeToCashState>(
      builder: (context, state) {
        final isLoading = state is AirtimeToCashVerifying;
        return Container(
          padding: EdgeInsets.all(20.w),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isLoading ? null : (_canProceed ? _verifyService : null),
              style: ElevatedButton.styleFrom(
                backgroundColor: _canProceed
                    ? const Color(0xFF4E03D0)
                    : const Color(0xFF1F1F1F),
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
                elevation: 0,
              ),
              child: isLoading
                  ? SizedBox(
                      width: 20.w,
                      height: 20.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Text(
                      'Check Availability',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: _canProceed ? Colors.white : const Color(0xFF9CA3AF),
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
