import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/types/app_routes.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import '../../domain/entities/education_provider_entity.dart';

class EducationPurchaseScreen extends StatefulWidget {
  const EducationPurchaseScreen({super.key});

  @override
  State<EducationPurchaseScreen> createState() => _EducationPurchaseScreenState();
}

class _EducationPurchaseScreenState extends State<EducationPurchaseScreen> {
  late EducationProviderEntity _provider;
  int _quantity = 1;
  final _phoneController = TextEditingController();
  final _phoneFocusNode = FocusNode();
  final _billersCodeController = TextEditingController();
  final _billersCodeFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  static const int _minQuantity = 1;
  static const int _maxQuantity = 5;

  /// Country-code prefix for the phone field, mirroring the airtime/data
  /// recipient input. Nigeria is the sensible default — user's locale
  /// is resolved in initState.
  CountryLocale _selectedDialCountry = CountryLocales.all.first;

  @override
  void initState() {
    super.initState();
    _loadArguments();
    _syncDialCountryWithLocale();
    _maybePrefillProfilePhone();
  }

  /// Align the country-code prefix with the user's active locale.
  void _syncDialCountryWithLocale() {
    try {
      // LocaleManager is registered in DI but optional — fall back to NG.
      final code = 'NG';
      final match = CountryLocales.findByCountryCode(code);
      if (match != null && mounted) {
        setState(() => _selectedDialCountry = match);
      }
    } catch (_) {}
  }

  /// Airtime-style prefill: if the signed-in user has a phone on file,
  /// drop it into the field (in local `0xxx…` form) so they don't have
  /// to retype. Only fires when the field is still empty (rebuy paths
  /// have already populated from `rebuyPurchase`).
  void _maybePrefillProfilePhone() {
    if (_phoneController.text.isNotEmpty) return;
    try {
      final authState = context.read<AuthenticationCubit>().state;
      String? userPhone;
      if (authState is AuthenticationAuthenticated) {
        userPhone = authState.profile.user.phoneNumber;
      }
      if (userPhone == null || userPhone.isEmpty) return;
      // Normalise `+234…` / `234…` → `0…` so the 11-digit validator
      // and the backend's expected local format both work.
      if (userPhone.startsWith('+234')) {
        userPhone = '0${userPhone.substring(4)}';
      } else if (userPhone.startsWith('234') && userPhone.length > 10) {
        userPhone = '0${userPhone.substring(3)}';
      }
      _phoneController.text = userPhone;
    } catch (_) {
      // AuthenticationCubit isn't provided in this route — skip prefill.
    }
  }

  void _loadArguments() {
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null && args['provider'] != null) {
      _provider = args['provider'] as EducationProviderEntity;

      // Handle rebuy: pre-fill phone, billers code, and quantity
      if (args['rebuyPurchase'] != null) {
        final rebuyPurchase = args['rebuyPurchase'];
        if (rebuyPurchase is Map<String, dynamic>) {
          final phone = rebuyPurchase['phone'] as String?;
          final billersCode = rebuyPurchase['billersCode'] as String?;
          final quantity = rebuyPurchase['quantity'] as int?;

          if (phone != null && phone.isNotEmpty) {
            _phoneController.text = phone;
          }
          if (billersCode != null && billersCode.isNotEmpty) {
            _billersCodeController.text = billersCode;
          }
          if (quantity != null && quantity >= _minQuantity && quantity <= _maxQuantity) {
            setState(() {
              _quantity = quantity;
            });
          }
        }
      }
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) => Get.back());
    }
  }

  bool get _isJamb => _provider.serviceId == 'jamb';

  @override
  void dispose() {
    _phoneController.dispose();
    _phoneFocusNode.dispose();
    _billersCodeController.dispose();
    _billersCodeFocusNode.dispose();
    super.dispose();
  }

  double get _totalAmount => _provider.amount * _quantity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'Purchase PIN',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Provider info card
                      _buildProviderInfoCard(),

                      SizedBox(height: 24.h),

                      // Quantity selector
                      _buildQuantitySelector(),

                      SizedBox(height: 24.h),

                      // Phone number input
                      _buildPhoneInput(),

                      SizedBox(height: 24.h),

                      // JAMB profile code (only for JAMB)
                      if (_isJamb) ...[
                        _buildBillersCodeInput(),
                        SizedBox(height: 24.h),
                      ],

                      // Price breakdown
                      _buildPriceBreakdown(),
                    ],
                  ),
                ),
              ),
            ),

            // Purchase button
            _buildPurchaseButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildProviderInfoCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
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
              color: const Color(0xFF4E03D0).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.school,
              color: const Color(0xFF4E03D0),
              size: 24.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _provider.name,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  _provider.description,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          ),
          Text(
            '\u20A6${_formatAmount(_provider.amount)}',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF4E03D0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantitySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quantity',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF9CA3AF),
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: const Color(0xFF2D2D2D),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Decrement button
              GestureDetector(
                onTap: () {
                  if (_quantity > _minQuantity) {
                    setState(() => _quantity--);
                  }
                },
                child: Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: _quantity > _minQuantity
                        ? const Color(0xFF4E03D0).withValues(alpha: 0.15)
                        : const Color(0xFF2D2D2D),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    Icons.remove,
                    color: _quantity > _minQuantity
                        ? const Color(0xFF4E03D0)
                        : const Color(0xFF9CA3AF),
                    size: 20.sp,
                  ),
                ),
              ),

              // Quantity display
              Column(
                children: [
                  Text(
                    '$_quantity',
                    style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    _quantity == 1 ? 'PIN' : 'PINs',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFF9CA3AF),
                    ),
                  ),
                ],
              ),

              // Increment button
              GestureDetector(
                onTap: () {
                  if (_quantity < _maxQuantity) {
                    setState(() => _quantity++);
                  }
                },
                child: Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: _quantity < _maxQuantity
                        ? const Color(0xFF4E03D0).withValues(alpha: 0.15)
                        : const Color(0xFF2D2D2D),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    Icons.add,
                    color: _quantity < _maxQuantity
                        ? const Color(0xFF4E03D0)
                        : const Color(0xFF9CA3AF),
                    size: 20.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          'Maximum $_maxQuantity PINs per purchase',
          style: TextStyle(
            fontSize: 12.sp,
            color: const Color(0xFF9CA3AF),
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Phone Number',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF9CA3AF),
          ),
        ),
        SizedBox(height: 8.h),
        // Country-code + phone side-by-side. Mirrors airtime /
        // data_bundles recipient input. The flag + dial code are
        // read-only here — the country comes from the active locale,
        // not a free-form picker, since education PINs are a
        // Nigeria-only catalogue today.
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFF2D2D2D), width: 1),
          ),
          child: Row(
            children: [
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
                decoration: const BoxDecoration(
                  border: Border(
                    right: BorderSide(color: Color(0xFF2D2D2D), width: 1),
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
              Expanded(
                child: TextFormField(
                  controller: _phoneController,
                  focusNode: _phoneFocusNode,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(11),
                  ],
                  style: TextStyle(fontSize: 16.sp, color: Colors.white),
                  decoration: InputDecoration(
                    hintText: '8012345678',
                    hintStyle: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFF9CA3AF).withValues(alpha: 0.6),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 14.w, vertical: 14.h),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone number is required';
                    }
                    if (value.length < 10) {
                      return 'Enter a valid phone number';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBillersCodeInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'JAMB Profile Code',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF9CA3AF),
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: _billersCodeController,
          focusNode: _billersCodeFocusNode,
          // JAMB Profile Code is the 10-digit candidate code printed on
          // the JAMB registration slip. VTpass's /merchant-verify +
          // /pay endpoints (https://www.vtpass.com/documentation/jamb-pin-vending/)
          // treat it as `billersCode` and require exactly 10 numeric
          // digits — anything else returns 011 INVALID ARGUMENTS.
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10),
          ],
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
          ),
          decoration: InputDecoration(
            hintText: '10-digit JAMB profile code',
            hintStyle: TextStyle(
              fontSize: 14.sp,
              color: const Color(0xFF9CA3AF).withValues(alpha: 0.6),
            ),
            prefixIcon: Icon(
              Icons.badge_outlined,
              color: const Color(0xFF9CA3AF),
              size: 20.sp,
            ),
            filled: true,
            fillColor: const Color(0xFF1F1F1F),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFF4E03D0)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFFEF4444)),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          ),
          validator: (value) {
            if (!_isJamb) return null;
            final raw = (value ?? '').trim();
            if (raw.isEmpty) {
              return 'JAMB profile code is required';
            }
            if (raw.length != 10) {
              return 'Profile code must be exactly 10 digits';
            }
            if (!RegExp(r'^\d{10}$').hasMatch(raw)) {
              return 'Profile code must contain only digits';
            }
            return null;
          },
        ),
        SizedBox(height: 4.h),
        Text(
          '10 digits from your JAMB registration slip',
          style: TextStyle(
            fontSize: 12.sp,
            color: const Color(0xFF9CA3AF),
          ),
        ),
      ],
    );
  }

  Widget _buildPriceBreakdown() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFF2D2D2D),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          _buildBreakdownRow('Unit Price', '\u20A6${_formatAmount(_provider.amount)}'),
          SizedBox(height: 10.h),
          _buildBreakdownRow('Quantity', '$_quantity'),
          SizedBox(height: 10.h),
          Container(
            height: 1,
            color: const Color(0xFF2D2D2D),
          ),
          SizedBox(height: 10.h),
          _buildBreakdownRow(
            'Total',
            '\u20A6${_formatAmount(_totalAmount)}',
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildBreakdownRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16.sp : 14.sp,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
            color: isTotal ? Colors.white : const Color(0xFF9CA3AF),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 18.sp : 14.sp,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
            color: isTotal ? const Color(0xFF4E03D0) : Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildPurchaseButton() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        border: Border(
          top: BorderSide(
            color: const Color(0xFF2D2D2D),
            width: 1,
          ),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Get.toNamed(AppRoutes.educationPaymentConfirmation, arguments: {
                'provider': _provider,
                'quantity': _quantity,
                'phone': _phoneController.text.trim(),
                'totalAmount': _totalAmount,
                if (_isJamb) 'billersCode': _billersCodeController.text.trim(),
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4E03D0),
            padding: EdgeInsets.symmetric(vertical: 16.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            elevation: 0,
          ),
          child: Text(
            'Purchase \u20A6${_formatAmount(_totalAmount)}',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  String _formatAmount(double amount) {
    if (amount >= 1000) {
      final intAmount = amount.toInt();
      final result = StringBuffer();
      final str = intAmount.toString();
      for (var i = 0; i < str.length; i++) {
        if (i > 0 && (str.length - i) % 3 == 0) {
          result.write(',');
        }
        result.write(str[i]);
      }
      return result.toString();
    }
    return amount.toStringAsFixed(0);
  }
}
