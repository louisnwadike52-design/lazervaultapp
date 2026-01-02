import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/provider_entity.dart';
import '../../domain/entities/bill_payment_entity.dart';
import '../../../../../core/types/app_routes.dart';
import '../cubit/electricity_bill_cubit.dart';
import '../cubit/electricity_bill_state.dart';

class MeterInputScreen extends StatefulWidget {
  const MeterInputScreen({super.key});

  @override
  State<MeterInputScreen> createState() => _MeterInputScreenState();
}

class _MeterInputScreenState extends State<MeterInputScreen> {
  final TextEditingController _meterNumberController = TextEditingController();
  MeterType _selectedMeterType = MeterType.prepaid;
  bool _isValidating = false;

  @override
  void dispose() {
    _meterNumberController.dispose();
    super.dispose();
  }

  void _validateMeter() {
    final provider = Get.arguments['provider'] as ElectricityProviderEntity;
    final meterNumber = _meterNumberController.text.trim();

    if (meterNumber.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your meter number',
        backgroundColor: Colors.red.withOpacity(0.9),
        colorText: Colors.white,
      );
      return;
    }

    context.read<ElectricityBillCubit>().validateMeter(
          providerCode: provider.providerCode,
          meterNumber: meterNumber,
          meterType: _selectedMeterType,
        );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Get.arguments['provider'] as ElectricityProviderEntity;

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
          child: BlocConsumer<ElectricityBillCubit, ElectricityBillState>(
            listener: (context, state) {
              if (state is MeterValidating) {
                setState(() {
                  _isValidating = true;
                });
              } else {
                setState(() {
                  _isValidating = false;
                });
              }

              if (state is MeterValidated) {
                Get.toNamed(
                  AppRoutes.electricityBillConfirmation,
                  arguments: {
                    'provider': provider,
                    'validationResult': state.validationResult,
                    'providerCode': state.providerCode,
                    'meterNumber': state.meterNumber,
                    'meterType': state.meterType,
                  },
                );
              }

              if (state is MeterValidationFailed) {
                Get.snackbar(
                  'Validation Failed',
                  state.message,
                  backgroundColor: Colors.red.withOpacity(0.9),
                  colorText: Colors.white,
                );
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
            builder: (context, state) {
              return Column(
                children: [
                  _buildHeader(provider),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildProviderCard(provider),
                          SizedBox(height: 24.h),
                          _buildMeterTypeSelector(),
                          SizedBox(height: 24.h),
                          _buildMeterNumberInput(),
                          SizedBox(height: 32.h),
                          _buildValidateButton(),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ElectricityProviderEntity provider) {
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
                  'Enter Meter Details',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  provider.providerName,
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

  Widget _buildProviderCard(ElectricityProviderEntity provider) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF4E03D0),
            const Color(0xFF6B21E0),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Container(
            width: 56.w,
            height: 56.w,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.bolt,
              color: Colors.white,
              size: 28.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  provider.providerName,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  provider.providerCode,
                  style: GoogleFonts.inter(
                    color: Colors.white.withOpacity(0.8),
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
                MeterType.prepaid,
                'Prepaid',
                Icons.payment,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildMeterTypeOption(
                MeterType.postpaid,
                'Postpaid',
                Icons.receipt_long,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMeterTypeOption(MeterType type, String label, IconData icon) {
    final isSelected = _selectedMeterType == type;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMeterType = type;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF4E03D0).withOpacity(0.2)
              : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF4E03D0)
                : Colors.white.withOpacity(0.1),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xFF4E03D0) : Colors.white.withOpacity(0.6),
              size: 32.sp,
            ),
            SizedBox(height: 12.h),
            Text(
              label,
              style: GoogleFonts.inter(
                color: isSelected ? Colors.white : Colors.white.withOpacity(0.6),
                fontSize: 16.sp,
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
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              hintText: 'Enter meter number',
              hintStyle: GoogleFonts.inter(
                color: Colors.white.withOpacity(0.4),
                fontSize: 18.sp,
              ),
              border: InputBorder.none,
              icon: Icon(
                Icons.numbers,
                color: Colors.white.withOpacity(0.4),
                size: 24.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildValidateButton() {
    return GestureDetector(
      onTap: _isValidating ? null : _validateMeter,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 18.h),
        decoration: BoxDecoration(
          gradient: _isValidating
              ? null
              : LinearGradient(
                  colors: [
                    const Color(0xFF4E03D0),
                    const Color(0xFF6B21E0),
                  ],
                ),
          color: _isValidating ? Colors.white.withOpacity(0.1) : null,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: _isValidating
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
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    color: Colors.white,
                    size: 24.sp,
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'Validate Meter',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
