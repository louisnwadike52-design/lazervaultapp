import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/country.dart';
import '../../domain/entities/network_provider.dart';
import '../cubit/airtime_cubit.dart';
import '../cubit/airtime_state.dart'; // ignore: unused_import (used by BlocBuilder)

class AirtimeTransferScreen extends StatefulWidget {
  const AirtimeTransferScreen({super.key});

  @override
  State<AirtimeTransferScreen> createState() => _AirtimeTransferScreenState();
}

class _AirtimeTransferScreenState extends State<AirtimeTransferScreen> {
  final _recipientPhoneController = TextEditingController();
  final _recipientNameController = TextEditingController();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  final _senderPhoneController = TextEditingController();

  NetworkProvider? _selectedProvider;
  bool _phoneValidated = false;
  String? _phoneError;

  @override
  void initState() {
    super.initState();
    context.read<AirtimeCubit>().loadNetworkProviders('NG');
  }

  @override
  void dispose() {
    _recipientPhoneController.dispose();
    _recipientNameController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    _senderPhoneController.dispose();
    super.dispose();
  }

  double get _amount => double.tryParse(_amountController.text) ?? 0;

  double get _commission {
    if (_amount <= 0 || _selectedProvider == null) return 0;
    final network = _selectedProvider!.type.name.toUpperCase();
    double rate = 0.05;
    if (network == 'GLO' || network == '9MOBILE') rate = 0.04;
    return (_amount * rate) + 25;
  }

  double get _totalCharged => _amount + _commission;

  bool get _canProceed =>
      _selectedProvider != null &&
      _phoneValidated &&
      _phoneError == null &&
      _amount >= 50 &&
      _amount <= 50000;

  void _validatePhone(String phone) {
    final clean = phone.replaceAll(RegExp(r'[^\d]'), '');
    setState(() {
      if (clean.length < 11) {
        _phoneValidated = false;
        _phoneError = clean.isEmpty ? null : 'Enter 11 digits';
      } else if (clean.length == 11 && clean.startsWith('0')) {
        _phoneValidated = true;
        _phoneError = null;
        // Auto-detect network
        _detectNetwork(clean);
      } else {
        _phoneValidated = false;
        _phoneError = 'Nigerian numbers must be 11 digits starting with 0';
      }
    });
  }

  void _detectNetwork(String phone) async {
    final cubit = context.read<AirtimeCubit>();
    final detected = await cubit.detectNetworkFromPhoneNumber(phone, 'NG');
    if (detected != null && mounted) {
      setState(() => _selectedProvider = detected);
    }
  }

  void _proceedToReview() {
    if (!_canProceed) return;

    Get.toNamed(
      AppRoutes.airtimeTransferReview,
      arguments: {
        'provider': _selectedProvider,
        'recipientPhone': _recipientPhoneController.text.trim(),
        'recipientName': _recipientNameController.text.trim(),
        'senderPhone': _senderPhoneController.text.trim(),
        'amount': _amount,
        'commission': _commission,
        'totalCharged': _totalCharged,
        'transferNote': _noteController.text.trim(),
        'country': const Country(
          id: 'ng',
          name: 'Nigeria',
          code: 'NG',
          dialCode: '+234',
          flag: '🇳🇬',
          currency: 'NGN',
          currencySymbol: '₦',
        ),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    _buildRecipientSection(),
                    SizedBox(height: 20.h),
                    _buildNetworkSelector(),
                    SizedBox(height: 20.h),
                    _buildAmountSection(),
                    SizedBox(height: 16.h),
                    _buildNoteField(),
                    SizedBox(height: 16.h),
                    if (_amount >= 50) _buildCommissionBreakdown(),
                    SizedBox(height: 24.h),
                    _buildProceedButton(),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
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
              child: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20.sp),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Transfer Airtime',
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Send airtime to any number',
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

  Widget _buildRecipientSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recipient Phone Number',
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
            border: _phoneError != null
                ? Border.all(color: const Color(0xFFEF4444))
                : null,
          ),
          child: TextField(
            controller: _recipientPhoneController,
            keyboardType: TextInputType.phone,
            style: TextStyle(color: Colors.white, fontSize: 16.sp),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(11),
            ],
            onChanged: _validatePhone,
            decoration: InputDecoration(
              hintText: '08012345678',
              hintStyle: TextStyle(color: const Color(0xFF6B7280), fontSize: 16.sp),
              prefixIcon: Icon(Icons.phone, color: const Color(0xFF9CA3AF), size: 20.sp),
              suffixIcon: _phoneValidated
                  ? Icon(Icons.check_circle, color: const Color(0xFF10B981), size: 20.sp)
                  : null,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            ),
          ),
        ),
        if (_phoneError != null) ...[
          SizedBox(height: 4.h),
          Text(
            _phoneError!,
            style: TextStyle(color: const Color(0xFFEF4444), fontSize: 12.sp),
          ),
        ],
        SizedBox(height: 12.h),
        // Recipient name (optional)
        Text(
          'Recipient Name (optional)',
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
            controller: _recipientNameController,
            style: TextStyle(color: Colors.white, fontSize: 16.sp),
            decoration: InputDecoration(
              hintText: 'Enter name',
              hintStyle: TextStyle(color: const Color(0xFF6B7280), fontSize: 16.sp),
              prefixIcon: Icon(Icons.person_outline, color: const Color(0xFF9CA3AF), size: 20.sp),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNetworkSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Network Provider',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.h),
        BlocBuilder<AirtimeCubit, AirtimeState>(
          builder: (context, state) {
            if (state is AirtimeNetworkProvidersLoaded) {
              return _buildProviderGrid(state.providers);
            }
            if (state is AirtimeNetworkProvidersLoading) {
              return Center(child: CircularProgressIndicator(strokeWidth: 2));
            }
            return SizedBox.shrink();
          },
        ),
      ],
    );
  }

  Widget _buildProviderGrid(List<NetworkProvider> providers) {
    return Wrap(
      spacing: 10.w,
      runSpacing: 10.h,
      children: providers.map((provider) {
        final isSelected = _selectedProvider?.id == provider.id;
        return GestureDetector(
          onTap: () => setState(() => _selectedProvider = provider),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: (MediaQuery.of(context).size.width - 70.w) / 2,
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
            decoration: BoxDecoration(
              color: isSelected
                  ? provider.type.color.withValues(alpha: 0.15)
                  : const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: isSelected ? provider.type.color : const Color(0xFF2D2D2D),
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    color: provider.type.color,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Center(
                    child: Text(
                      provider.name.substring(0, 1),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    provider.name,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : const Color(0xFF9CA3AF),
                    ),
                  ),
                ),
                if (isSelected)
                  Icon(Icons.check_circle, color: provider.type.color, size: 18.sp),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAmountSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Amount',
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
            keyboardType: TextInputType.number,
            style: TextStyle(color: Colors.white, fontSize: 24.sp, fontWeight: FontWeight.w700),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: '0',
              hintStyle: TextStyle(color: const Color(0xFF6B7280), fontSize: 24.sp, fontWeight: FontWeight.w700),
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 16.w, right: 8.w),
                child: Text(
                  '\u20A6',
                  style: TextStyle(
                    color: const Color(0xFFFB923C),
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        // Quick amount buttons
        Row(
          children: [100, 200, 500, 1000, 5000].map((amt) {
            return Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: GestureDetector(
                  onTap: () {
                    _amountController.text = amt.toString();
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    decoration: BoxDecoration(
                      color: _amount == amt.toDouble()
                          ? const Color(0xFFFB923C).withValues(alpha: 0.15)
                          : const Color(0xFF1F1F1F),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: _amount == amt.toDouble()
                            ? const Color(0xFFFB923C)
                            : const Color(0xFF2D2D2D),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '\u20A6$amt',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: _amount == amt.toDouble()
                              ? const Color(0xFFFB923C)
                              : const Color(0xFF9CA3AF),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        if (_amount > 0 && _amount < 50) ...[
          SizedBox(height: 4.h),
          Text('Minimum transfer is \u20A650',
              style: TextStyle(color: const Color(0xFFEF4444), fontSize: 12.sp)),
        ],
        if (_amount > 50000) ...[
          SizedBox(height: 4.h),
          Text('Maximum transfer is \u20A650,000',
              style: TextStyle(color: const Color(0xFFEF4444), fontSize: 12.sp)),
        ],
      ],
    );
  }

  Widget _buildNoteField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Transfer Note (optional)',
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
            controller: _noteController,
            style: TextStyle(color: Colors.white, fontSize: 14.sp),
            maxLines: 2,
            maxLength: 100,
            decoration: InputDecoration(
              hintText: 'e.g. For airtime top-up',
              hintStyle: TextStyle(color: const Color(0xFF6B7280), fontSize: 14.sp),
              counterStyle: TextStyle(color: const Color(0xFF6B7280)),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCommissionBreakdown() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Fee Breakdown',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 12.h),
          _feeRow('Airtime to deliver', '\u20A6${_amount.toStringAsFixed(0)}'),
          SizedBox(height: 8.h),
          _feeRow('Commission', '\u20A6${_commission.toStringAsFixed(2)}', valueColor: const Color(0xFFFB923C)),
          SizedBox(height: 8.h),
          Container(height: 1, color: Colors.white.withValues(alpha: 0.1)),
          SizedBox(height: 8.h),
          _feeRow('Total charge', '\u20A6${_totalCharged.toStringAsFixed(2)}', isTotal: true),
        ],
      ),
    );
  }

  Widget _feeRow(String label, String value, {Color? valueColor, bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 15.sp : 13.sp,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w400,
            color: isTotal ? Colors.white : const Color(0xFF9CA3AF),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 15.sp : 13.sp,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
            color: valueColor ?? (isTotal ? Colors.white : Colors.white.withValues(alpha: 0.8)),
          ),
        ),
      ],
    );
  }

  Widget _buildProceedButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _canProceed ? _proceedToReview : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFB923C),
          disabledBackgroundColor: const Color(0xFF2D2D2D),
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
          elevation: 0,
        ),
        child: Text(
          'Review Transfer',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
