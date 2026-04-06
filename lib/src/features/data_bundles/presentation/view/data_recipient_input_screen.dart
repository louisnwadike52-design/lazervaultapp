import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/types/app_routes.dart';
import '../../../../../core/services/locale_manager.dart';
import '../../domain/entities/data_plan_entity.dart';

class DataRecipientInputScreen extends StatefulWidget {
  const DataRecipientInputScreen({super.key});

  @override
  State<DataRecipientInputScreen> createState() =>
      _DataRecipientInputScreenState();
}

class _DataRecipientInputScreenState extends State<DataRecipientInputScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  CountryLocale _selectedDialCountry = CountryLocales.all.first; // Nigeria default
  String? _validationError;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  /// Build full E.164 phone number with country dial code.
  String _buildFullPhone() {
    final local = _phoneController.text.trim().replaceAll(RegExp(r'[^\d]'), '');
    final stripped = local.startsWith('0') ? local.substring(1) : local;
    return '${_selectedDialCountry.dialCode}$stripped';
  }

  void _onPhoneChanged(String value) {
    final phoneNumber = value.replaceAll(RegExp(r'[^\d]'), '');
    final stripped = phoneNumber.startsWith('0') ? phoneNumber.substring(1) : phoneNumber;

    // Clear error when user starts typing valid input
    if (stripped.length >= 10 && _validationError != null) {
      setState(() {
        _validationError = null;
      });
    }

    // Validate phone number
    if (stripped.isEmpty) {
      setState(() {
        _validationError = 'Phone number is required';
      });
    } else if (stripped.length < 10) {
      setState(() {
        _validationError = 'Phone number must be 10 digits';
      });
    } else {
      setState(() {
        _validationError = null;
      });
    }
  }

  void _onContinue() {
    final localDigits = _phoneController.text.trim().replaceAll(RegExp(r'[^\d]'), '');
    final stripped = localDigits.startsWith('0') ? localDigits.substring(1) : localDigits;

    if (stripped.isEmpty) {
      setState(() {
        _validationError = 'Phone number is required';
      });
      return;
    }

    if (stripped.length < 10) {
      setState(() {
        _validationError = 'Phone number must be 10 digits';
      });
      return;
    }

    if (_validationError == null) {
      final args = Get.arguments as Map<String, dynamic>;
      final plan = args['plan'] as DataPlanEntity;
      final network = args['network'] as String;
      final networkName = args['networkName'] as String;
      final networkColorValue = args['networkColor'] as int;

      Get.toNamed(
        AppRoutes.dataBundlesPaymentConfirmation,
        arguments: {
          'plan': plan,
          'network': network,
          'networkName': networkName,
          'networkColor': networkColorValue,
          'phoneNumber': _buildFullPhone(),
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final networkName = args['networkName'] as String;
    final networkColorValue = args['networkColor'] as int;
    final networkColor = Color(networkColorValue);

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 22.sp,
          ),
        ),
        title: Text(
          'Phone Number',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),

              // Network info card
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: const Color(0xFF2D2D2D),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48.w,
                      height: 48.w,
                      decoration: BoxDecoration(
                        color: networkColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(
                        Icons.cell_tower,
                        color: networkColor,
                        size: 24.sp,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            networkName,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Enter the phone number to receive data',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF9CA3AF),
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 28.h),

              // Phone number input form
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Phone Number',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF1F1F1F),
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(
                        color: _validationError != null
                            ? const Color(0xFFEF4444)
                            : const Color(0xFF2D2D2D),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        // Country code prefix (display only - Nigeria)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
                          decoration: const BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: Color(0xFF2D2D2D),
                                width: 1,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                _selectedDialCountry.flag,
                                style: TextStyle(fontSize: 20.sp),
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                _selectedDialCountry.dialCode,
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Phone number input
                        Expanded(
                          child: TextField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(11),
                            ],
                            onChanged: _onPhoneChanged,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              hintText: '801 234 5678',
                              hintStyle: GoogleFonts.inter(
                                color: const Color(0xFF9CA3AF).withValues(alpha: 0.5),
                                fontSize: 16.sp,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 14.w,
                                vertical: 16.h,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_validationError != null) ...[
                    SizedBox(height: 6.h),
                    Padding(
                      padding: EdgeInsets.only(left: 14.w),
                      child: Text(
                        _validationError!,
                        style: GoogleFonts.inter(
                          color: const Color(0xFFEF4444),
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ],
                  SizedBox(height: 6.h),
                  Text(
                    'Enter the 10-digit phone number (excluding leading 0)',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF).withValues(alpha: 0.6),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),

              const Spacer(),

              // Continue button
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: _onContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B82F6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Continue',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}
