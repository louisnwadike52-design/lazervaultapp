import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/provider_entity.dart';
import '../../domain/entities/bill_payment_entity.dart';
import '../../domain/repositories/electricity_bill_repository.dart';
import '../../../../../core/types/app_routes.dart';
import '../cubit/electricity_bill_cubit.dart';
import '../cubit/electricity_bill_state.dart';
import '../cubit/beneficiary_cubit.dart';
import '../cubit/beneficiary_state.dart';

class AddBeneficiaryScreen extends StatefulWidget {
  const AddBeneficiaryScreen({super.key});

  @override
  State<AddBeneficiaryScreen> createState() => _AddBeneficiaryScreenState();
}

class _AddBeneficiaryScreenState extends State<AddBeneficiaryScreen> {
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _meterNumberController = TextEditingController();

  ElectricityProviderEntity? _selectedProvider;
  MeterType _selectedMeterType = MeterType.prepaid;
  MeterValidationResult? _validationResult;
  bool _isValidated = false;
  bool _setAsDefault = false;

  @override
  void initState() {
    super.initState();
    context.read<ElectricityBillCubit>().getProviders(country: 'NG');
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _meterNumberController.dispose();
    super.dispose();
  }

  void _validateMeter() {
    if (_selectedProvider == null) {
      Get.snackbar(
        'Error',
        'Please select a provider',
        backgroundColor: Colors.red.withOpacity(0.9),
        colorText: Colors.white,
      );
      return;
    }

    final meterNumber = _meterNumberController.text.trim();
    if (meterNumber.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter meter number',
        backgroundColor: Colors.red.withOpacity(0.9),
        colorText: Colors.white,
      );
      return;
    }

    context.read<ElectricityBillCubit>().validateMeter(
          providerCode: _selectedProvider!.providerCode,
          meterNumber: meterNumber,
          meterType: _selectedMeterType,
        );
  }

  void _saveBeneficiary() {
    if (!_isValidated || _validationResult == null) {
      Get.snackbar(
        'Error',
        'Please validate the meter first',
        backgroundColor: Colors.red.withOpacity(0.9),
        colorText: Colors.white,
      );
      return;
    }

    final nickname = _nicknameController.text.trim();
    if (nickname.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter a nickname',
        backgroundColor: Colors.red.withOpacity(0.9),
        colorText: Colors.white,
      );
      return;
    }

    context.read<BeneficiaryCubit>().addBeneficiary(
          providerId: _selectedProvider!.id,
          providerCode: _selectedProvider!.providerCode,
          providerName: _selectedProvider!.providerName,
          meterNumber: _validationResult!.meterNumber,
          customerName: _validationResult!.customerName,
          customerAddress: _validationResult!.customerAddress,
          meterType: _selectedMeterType,
          nickname: nickname,
          isDefault: _setAsDefault,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A1A3E),
              const Color(0xFF0A0E27),
              const Color(0xFF0F0F23),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: MultiBlocListener(
                  listeners: [
                    BlocListener<ElectricityBillCubit, ElectricityBillState>(
                      listener: (context, state) {
                        if (state is MeterValidated) {
                          setState(() {
                            _validationResult = state.validationResult;
                            _isValidated = true;
                          });
                          Get.snackbar(
                            'Success',
                            'Meter validated successfully',
                            backgroundColor: Colors.green.withOpacity(0.9),
                            colorText: Colors.white,
                          );
                        }

                        if (state is MeterValidationFailed) {
                          setState(() {
                            _isValidated = false;
                            _validationResult = null;
                          });
                        }

                        if (state is ElectricityBillError) {
                          Get.snackbar(
                            'Error',
                            state.message,
                            backgroundColor: Colors.red.withOpacity(0.9),
                            colorText: Colors.white,
                          );
                        }
                      },
                    ),
                    BlocListener<BeneficiaryCubit, BeneficiaryState>(
                      listener: (context, state) {
                        if (state is BeneficiarySaved) {
                          Get.snackbar(
                            'Success',
                            state.message,
                            backgroundColor: Colors.green.withOpacity(0.9),
                            colorText: Colors.white,
                          );
                          Get.back();
                        }

                        if (state is BeneficiaryError) {
                          Get.snackbar(
                            'Error',
                            state.message,
                            backgroundColor: Colors.red.withOpacity(0.9),
                            colorText: Colors.white,
                          );
                        }
                      },
                    ),
                  ],
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildProviderSelector(),
                        SizedBox(height: 24.h),
                        _buildMeterTypeSelector(),
                        SizedBox(height: 24.h),
                        _buildMeterNumberInput(),
                        SizedBox(height: 24.h),
                        _buildValidateButton(),
                        if (_isValidated && _validationResult != null) ...[
                          SizedBox(height: 24.h),
                          _buildValidationResult(),
                          SizedBox(height: 24.h),
                          _buildNicknameInput(),
                          SizedBox(height: 16.h),
                          _buildDefaultCheckbox(),
                          SizedBox(height: 32.h),
                          _buildSaveButton(),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(22.r),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1,
                ),
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
                  'Add Beneficiary',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Save meter for quick payments',
                  style: GoogleFonts.inter(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProviderSelector() {
    return BlocBuilder<ElectricityBillCubit, ElectricityBillState>(
      builder: (context, state) {
        if (state is ProvidersLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Provider',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.1),
                    width: 1,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<ElectricityProviderEntity>(
                    value: _selectedProvider,
                    hint: Text(
                      'Choose electricity provider',
                      style: GoogleFonts.inter(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 14.sp,
                      ),
                    ),
                    isExpanded: true,
                    dropdownColor: const Color(0xFF1A1A3E),
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white.withOpacity(0.6),
                    ),
                    items: state.providers.map((provider) {
                      return DropdownMenuItem(
                        value: provider,
                        child: Text(
                          provider.providerName,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 14.sp,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedProvider = value;
                        _isValidated = false;
                        _validationResult = null;
                      });
                    },
                  ),
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildMeterTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Meter Type',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: _buildMeterTypeOption(
                'Prepaid',
                MeterType.prepaid,
                Icons.bolt,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildMeterTypeOption(
                'Postpaid',
                MeterType.postpaid,
                Icons.receipt_long,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMeterTypeOption(String label, MeterType type, IconData icon) {
    final isSelected = _selectedMeterType == type;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMeterType = type;
          _isValidated = false;
          _validationResult = null;
        });
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF4E03D0).withOpacity(0.2)
              : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF4E03D0) : Colors.white.withOpacity(0.1),
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xFF4E03D0) : Colors.white.withOpacity(0.6),
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              label,
              style: GoogleFonts.inter(
                color: isSelected ? const Color(0xFF4E03D0) : Colors.white.withOpacity(0.8),
                fontSize: 14.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMeterNumberInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Meter Number',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: TextField(
            controller: _meterNumberController,
            keyboardType: TextInputType.number,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: 'Enter meter number',
              hintStyle: GoogleFonts.inter(
                color: Colors.white.withOpacity(0.3),
                fontSize: 16.sp,
              ),
              border: InputBorder.none,
              suffixIcon: _isValidated
                  ? Icon(Icons.check_circle, color: Colors.green, size: 24.sp)
                  : null,
            ),
            onChanged: (value) {
              if (_isValidated) {
                setState(() {
                  _isValidated = false;
                  _validationResult = null;
                });
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildValidateButton() {
    return BlocBuilder<ElectricityBillCubit, ElectricityBillState>(
      builder: (context, state) {
        final isLoading = state is MeterValidating;

        return GestureDetector(
          onTap: isLoading ? null : _validateMeter,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 18.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF4E03D0),
                  const Color(0xFF6B21E0),
                ],
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: isLoading
                ? Center(
                    child: SizedBox(
                      width: 24.w,
                      height: 24.w,
                      child: const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    ),
                  )
                : Text(
                    'Validate Meter',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
          ),
        );
      },
    );
  }

  Widget _buildValidationResult() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF4E03D0),
            const Color(0xFF6B21E0),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.verified, color: Colors.white, size: 20.sp),
              SizedBox(width: 8.w),
              Text(
                'Meter Verified',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildResultRow('Customer Name', _validationResult!.customerName),
          if (_validationResult!.customerAddress != null)
            _buildResultRow('Address', _validationResult!.customerAddress!),
          _buildResultRow('Meter Number', _validationResult!.meterNumber),
        ],
      ),
    );
  }

  Widget _buildResultRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100.w,
            child: Text(
              label,
              style: GoogleFonts.inter(
                color: Colors.white.withOpacity(0.8),
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNicknameInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nickname',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: TextField(
            controller: _nicknameController,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: 'e.g., Home, Office, Mom\'s House',
              hintStyle: GoogleFonts.inter(
                color: Colors.white.withOpacity(0.3),
                fontSize: 16.sp,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDefaultCheckbox() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _setAsDefault = !_setAsDefault;
        });
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                color: _setAsDefault ? const Color(0xFF4E03D0) : Colors.transparent,
                borderRadius: BorderRadius.circular(6.r),
                border: Border.all(
                  color: _setAsDefault
                      ? const Color(0xFF4E03D0)
                      : Colors.white.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: _setAsDefault
                  ? Icon(Icons.check, color: Colors.white, size: 16.sp)
                  : null,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                'Set as default beneficiary',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return BlocBuilder<BeneficiaryCubit, BeneficiaryState>(
      builder: (context, state) {
        final isLoading = state is BeneficiarySaving;

        return GestureDetector(
          onTap: isLoading ? null : _saveBeneficiary,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 18.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF4E03D0),
                  const Color(0xFF6B21E0),
                ],
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: isLoading
                ? Center(
                    child: SizedBox(
                      width: 24.w,
                      height: 24.w,
                      child: const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    ),
                  )
                : Text(
                    'Save Beneficiary',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
          ),
        );
      },
    );
  }
}
