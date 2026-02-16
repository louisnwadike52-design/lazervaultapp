import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/types/app_routes.dart';
import '../../domain/entities/id_pay_entity.dart';
import '../cubit/id_pay_cubit.dart';
import '../cubit/id_pay_state.dart';

class CreateIDPayScreen extends StatefulWidget {
  const CreateIDPayScreen({super.key});

  @override
  State<CreateIDPayScreen> createState() => _CreateIDPayScreenState();
}

class _CreateIDPayScreenState extends State<CreateIDPayScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  // Step 1: Type
  IDPayType _selectedType = IDPayType.oneTime;

  // Step 2: Amount Mode
  IDPayAmountMode _selectedAmountMode = IDPayAmountMode.fixed;
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _minAmountController = TextEditingController();
  final TextEditingController _maxAmountController = TextEditingController();

  // Step 3: Details
  final TextEditingController _descriptionController = TextEditingController();
  String _selectedExpiry = '24hr';
  String _selectedCurrency = 'NGN';
  final TextEditingController _customExpiryController = TextEditingController();

  static const Map<String, int> _expiryOptions = {
    '15min': 15,
    '1hr': 60,
    '24hr': 1440,
    '7 days': 10080,
    '30 days': 43200,
    'Custom': -1,
  };

  static const List<String> _currencies = ['NGN', 'USD', 'GBP', 'EUR'];

  @override
  void dispose() {
    _pageController.dispose();
    _amountController.dispose();
    _minAmountController.dispose();
    _maxAmountController.dispose();
    _descriptionController.dispose();
    _customExpiryController.dispose();
    super.dispose();
  }

  void _goToStep(int step) {
    setState(() => _currentStep = step);
    _pageController.animateToPage(
      step,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onNext() {
    if (_currentStep < 3) {
      _goToStep(_currentStep + 1);
    }
  }

  void _onBack() {
    if (_currentStep > 0) {
      _goToStep(_currentStep - 1);
    } else {
      Get.back();
    }
  }

  int get _validityMinutes {
    if (_selectedExpiry == 'Custom') {
      final custom = int.tryParse(_customExpiryController.text.trim());
      return custom ?? 1440;
    }
    return _expiryOptions[_selectedExpiry] ?? 1440;
  }

  void _onCreate() {
    final cubit = context.read<IDPayCubit>();
    cubit.createIDPay(
      type: _selectedType,
      amountMode: _selectedAmountMode,
      amount: _selectedAmountMode == IDPayAmountMode.fixed
          ? double.tryParse(_amountController.text.trim()) ?? 0.0
          : 0.0,
      currency: _selectedCurrency,
      minAmount: _selectedAmountMode == IDPayAmountMode.flexible
          ? double.tryParse(_minAmountController.text.trim())
          : null,
      maxAmount: _selectedAmountMode == IDPayAmountMode.flexible
          ? double.tryParse(_maxAmountController.text.trim())
          : null,
      description: _descriptionController.text.trim().isNotEmpty
          ? _descriptionController.text.trim()
          : null,
      validityMinutes: _validityMinutes,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<IDPayCubit, IDPayState>(
      listener: (context, state) {
        if (state is IDPayCreated) {
          Get.offNamed('/id-pay/created', arguments: {'idPay': state.idPay});
        } else if (state is IDPayError) {
          Get.snackbar(
            'Error',
            state.message,
            backgroundColor: const Color(0xFFEF4444),
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            margin: EdgeInsets.all(16.w),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: _onBack,
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 24.sp,
            ),
          ),
          title: Text(
            'Create IDPay',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            children: [
              _buildStepIndicator(),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) =>
                      setState(() => _currentStep = index),
                  children: [
                    _buildTypeStep(),
                    _buildAmountModeStep(),
                    _buildDetailsStep(),
                    _buildReviewStep(),
                  ],
                ),
              ),
              _buildBottomBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: List.generate(4, (index) {
          final isActive = index <= _currentStep;
          return Expanded(
            child: Container(
              height: 4.h,
              margin: EdgeInsets.symmetric(horizontal: 2.w),
              decoration: BoxDecoration(
                color: isActive
                    ? const Color(0xFF3B82F6)
                    : const Color(0xFF2D2D2D),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          );
        }),
      ),
    );
  }

  // Step 1: Type Selection
  Widget _buildTypeStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Type',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Choose whether this PayID can be used once or multiple times',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 24.h),
          _buildTypeCard(
            type: IDPayType.oneTime,
            icon: Icons.looks_one_outlined,
            title: 'One-Time',
            subtitle: 'Can only be paid once. Ideal for single invoices or requests.',
          ),
          SizedBox(height: 12.h),
          _buildTypeCard(
            type: IDPayType.recurring,
            icon: Icons.repeat,
            title: 'Recurring',
            subtitle:
                'Can be paid multiple times by different people. Great for donations or recurring collections.',
          ),
        ],
      ),
    );
  }

  Widget _buildTypeCard({
    required IDPayType type,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final isSelected = _selectedType == type;
    return GestureDetector(
      onTap: () => setState(() => _selectedType = type),
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF3B82F6)
                : const Color(0xFF2D2D2D),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 52.w,
              height: 52.w,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF3B82F6).withValues(alpha: 0.15)
                    : const Color(0xFF2D2D2D),
                borderRadius: BorderRadius.circular(26.r),
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? const Color(0xFF3B82F6)
                    : const Color(0xFF9CA3AF),
                size: 26.sp,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: const Color(0xFF3B82F6),
                size: 24.sp,
              ),
          ],
        ),
      ),
    );
  }

  // Step 2: Amount Mode
  Widget _buildAmountModeStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Amount Mode',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Set a fixed amount or let payers choose how much to pay',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 24.h),
          _buildAmountModeCard(
            mode: IDPayAmountMode.fixed,
            icon: Icons.lock_outline,
            title: 'Fixed Amount',
            subtitle: 'Payers will pay the exact amount you specify.',
          ),
          SizedBox(height: 12.h),
          _buildAmountModeCard(
            mode: IDPayAmountMode.flexible,
            icon: Icons.tune,
            title: 'Flexible Amount',
            subtitle:
                'Payers choose their own amount. Optionally set min/max limits.',
          ),
          SizedBox(height: 24.h),
          if (_selectedAmountMode == IDPayAmountMode.fixed) ...[
            Text(
              'Amount',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            _buildAmountField(
              controller: _amountController,
              hint: '0.00',
            ),
          ] else ...[
            Text(
              'Minimum Amount (Optional)',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            _buildAmountField(
              controller: _minAmountController,
              hint: 'No minimum',
            ),
            SizedBox(height: 16.h),
            Text(
              'Maximum Amount (Optional)',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            _buildAmountField(
              controller: _maxAmountController,
              hint: 'No maximum',
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAmountModeCard({
    required IDPayAmountMode mode,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final isSelected = _selectedAmountMode == mode;
    return GestureDetector(
      onTap: () => setState(() => _selectedAmountMode = mode),
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF3B82F6)
                : const Color(0xFF2D2D2D),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 52.w,
              height: 52.w,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF3B82F6).withValues(alpha: 0.15)
                    : const Color(0xFF2D2D2D),
                borderRadius: BorderRadius.circular(26.r),
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? const Color(0xFF3B82F6)
                    : const Color(0xFF9CA3AF),
                size: 26.sp,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: const Color(0xFF3B82F6),
                size: 24.sp,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountField({
    required TextEditingController controller,
    required String hint,
  }) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
      ],
      style: GoogleFonts.inter(
        color: Colors.white,
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(
          color: const Color(0xFF6B7280),
          fontSize: 18.sp,
        ),
        prefixText: '${_currencySymbol(_selectedCurrency)} ',
        prefixStyle: GoogleFonts.inter(
          color: const Color(0xFF3B82F6),
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
        filled: true,
        fillColor: const Color(0xFF1F1F1F),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      ),
    );
  }

  // Step 3: Details
  Widget _buildDetailsStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Details',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Add a description and set the expiry duration',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            'Description',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          TextField(
            controller: _descriptionController,
            maxLines: 3,
            maxLength: 200,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 15.sp,
            ),
            decoration: InputDecoration(
              hintText: 'What is this payment for?',
              hintStyle: GoogleFonts.inter(
                color: const Color(0xFF6B7280),
                fontSize: 15.sp,
              ),
              filled: true,
              fillColor: const Color(0xFF1F1F1F),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.r),
                borderSide: BorderSide.none,
              ),
              counterStyle: GoogleFonts.inter(
                color: const Color(0xFF6B7280),
                fontSize: 12.sp,
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            'Expiry Duration',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: _expiryOptions.keys.map((option) {
              final isSelected = _selectedExpiry == option;
              return GestureDetector(
                onTap: () => setState(() => _selectedExpiry = option),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF3B82F6).withValues(alpha: 0.2)
                        : const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF3B82F6)
                          : const Color(0xFF2D2D2D),
                    ),
                  ),
                  child: Text(
                    option,
                    style: GoogleFonts.inter(
                      color: isSelected
                          ? const Color(0xFF3B82F6)
                          : const Color(0xFF9CA3AF),
                      fontSize: 13.sp,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          if (_selectedExpiry == 'Custom') ...[
            SizedBox(height: 12.h),
            TextField(
              controller: _customExpiryController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 15.sp,
              ),
              decoration: InputDecoration(
                hintText: 'Duration in minutes',
                hintStyle: GoogleFonts.inter(
                  color: const Color(0xFF6B7280),
                  fontSize: 15.sp,
                ),
                suffixText: 'minutes',
                suffixStyle: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 13.sp,
                ),
                filled: true,
                fillColor: const Color(0xFF1F1F1F),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.r),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              ),
            ),
          ],
          SizedBox(height: 20.h),
          Text(
            'Currency',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedCurrency,
                isExpanded: true,
                dropdownColor: const Color(0xFF1F1F1F),
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: const Color(0xFF9CA3AF),
                  size: 20.sp,
                ),
                items: _currencies.map((currency) {
                  return DropdownMenuItem(
                    value: currency,
                    child: Text(
                      '$currency (${_currencySymbol(currency)})',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedCurrency = value);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Step 4: Review
  Widget _buildReviewStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Review & Confirm',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Please review your IDPay details before creating',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 24.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildReviewRow('Type', _selectedType.displayName),
                SizedBox(height: 16.h),
                _buildReviewRow(
                    'Amount Mode', _selectedAmountMode.displayName),
                SizedBox(height: 16.h),
                if (_selectedAmountMode == IDPayAmountMode.fixed) ...[
                  _buildReviewRow(
                    'Amount',
                    '${_currencySymbol(_selectedCurrency)}${_amountController.text.isNotEmpty ? _amountController.text : "0.00"}',
                  ),
                ] else ...[
                  _buildReviewRow(
                    'Min Amount',
                    _minAmountController.text.isNotEmpty
                        ? '${_currencySymbol(_selectedCurrency)}${_minAmountController.text}'
                        : 'No minimum',
                  ),
                  SizedBox(height: 16.h),
                  _buildReviewRow(
                    'Max Amount',
                    _maxAmountController.text.isNotEmpty
                        ? '${_currencySymbol(_selectedCurrency)}${_maxAmountController.text}'
                        : 'No maximum',
                  ),
                ],
                SizedBox(height: 16.h),
                _buildReviewRow('Currency', _selectedCurrency),
                SizedBox(height: 16.h),
                _buildReviewRow(
                  'Expiry',
                  _selectedExpiry == 'Custom'
                      ? '${_customExpiryController.text} minutes'
                      : _selectedExpiry,
                ),
                if (_descriptionController.text.trim().isNotEmpty) ...[
                  SizedBox(height: 16.h),
                  _buildReviewRow(
                      'Description', _descriptionController.text.trim()),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 16.w),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    return BlocBuilder<IDPayCubit, IDPayState>(
      builder: (context, state) {
        final isLoading = state is IDPayLoading;
        return Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          child: Row(
            children: [
              if (_currentStep > 0)
                Expanded(
                  child: OutlinedButton(
                    onPressed: isLoading ? null : _onBack,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Color(0xFF3B82F6)),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Back',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              if (_currentStep > 0) SizedBox(width: 12.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : (_currentStep == 3 ? _onCreate : _onNext),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B82F6),
                    disabledBackgroundColor:
                        const Color(0xFF3B82F6).withValues(alpha: 0.5),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
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
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text(
                          _currentStep == 3 ? 'Create' : 'Next',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _currencySymbol(String currency) {
    switch (currency.toUpperCase()) {
      case 'NGN':
        return '\u20A6';
      case 'USD':
        return '\$';
      case 'GBP':
        return '\u00A3';
      case 'EUR':
        return '\u20AC';
      default:
        return '$currency ';
    }
  }
}
