import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import '../../domain/entities/beneficiary_entity.dart';
import '../../domain/entities/provider_entity.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import '../../domain/entities/bill_payment_entity.dart';
import '../../domain/repositories/electricity_bill_repository.dart';
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
  final TextEditingController _phoneController = TextEditingController();

  ElectricityProviderEntity? _selectedProvider;
  MeterType _selectedMeterType = MeterType.prepaid;
  MeterValidationResult? _validationResult;
  bool _isValidated = false;
  bool _setAsDefault = false;
  bool _useSmartLookup = true;

  // Providers list cached from ProvidersLoaded state
  List<ElectricityProviderEntity> _providers = [];

  @override
  void initState() {
    super.initState();
    context.read<ElectricityBillCubit>().getProviders(country: serviceLocator<LocaleManager>().currentCountry);
    _prefillPhone();
  }

  void _prefillPhone() {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is AuthenticationSuccess) {
      final phone = authState.profile.user.phoneNumber ?? '';
      if (phone.isNotEmpty) {
        _phoneController.text = phone;
      }
    }
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _meterNumberController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _smartValidateMeter() {
    final meterNumber = _meterNumberController.text.trim();
    if (meterNumber.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter meter number',
        backgroundColor: Colors.red.withValues(alpha: 0.9),
        colorText: Colors.white,
      );
      return;
    }

    context.read<ElectricityBillCubit>().smartValidateMeter(meterNumber: meterNumber);
  }

  void _validateMeter() {
    if (_selectedProvider == null) {
      Get.snackbar(
        'Error',
        'Please select a provider',
        backgroundColor: Colors.red.withValues(alpha: 0.9),
        colorText: Colors.white,
      );
      return;
    }

    final meterNumber = _meterNumberController.text.trim();
    if (meterNumber.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter meter number',
        backgroundColor: Colors.red.withValues(alpha: 0.9),
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
        backgroundColor: Colors.red.withValues(alpha: 0.9),
        colorText: Colors.white,
      );
      return;
    }

    final nickname = _nicknameController.text.trim();
    if (nickname.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter a nickname',
        backgroundColor: Colors.red.withValues(alpha: 0.9),
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
          phoneNumber: _phoneController.text.trim().isNotEmpty
              ? _phoneController.text.trim()
              : null,
        );
  }

  void _onSmartValidationSuccess(SmartMeterValidationResult smartResult) {
    // Find matching provider from loaded providers list
    final matchedProvider = _providers.where(
      (p) => p.providerCode.toLowerCase() == smartResult.providerCode.toLowerCase(),
    );

    if (matchedProvider.isNotEmpty) {
      _selectedProvider = matchedProvider.first;
    }

    // Determine meter type from smart result
    final meterTypeStr = smartResult.meterType.toLowerCase();
    _selectedMeterType = meterTypeStr.contains('postpaid')
        ? MeterType.postpaid
        : MeterType.prepaid;

    // Construct MeterValidationResult from smart result
    _validationResult = MeterValidationResult(
      customerName: smartResult.customerName,
      customerAddress: smartResult.customerAddress,
      meterNumber: smartResult.meterNumber,
      meterType: _selectedMeterType,
      isValid: true,
    );
    _isValidated = true;
  }

  void _showBeneficiarySavedSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      enableDrag: false,
      builder: (ctx) => Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A3E),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 12.h),
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 24.h),
            Container(
              width: 60.w,
              height: 60.w,
              decoration: BoxDecoration(
                color: const Color(0xFF10B981).withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle,
                color: const Color(0xFF10B981),
                size: 32.sp,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Beneficiary Saved!',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              '${_validationResult?.customerName ?? _nicknameController.text.trim()} has been saved.',
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.6),
                fontSize: 14.sp,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.h),
            // Proceed to Payment button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(ctx).pop();
                  // Go back twice: add_beneficiary -> beneficiaries -> home
                  // Pass the beneficiary back through the chain
                  final beneficiary = BillBeneficiaryEntity(
                    id: '',
                    userId: '',
                    providerId: _selectedProvider?.id ?? '',
                    providerCode: _selectedProvider?.providerCode ?? '',
                    providerName: _selectedProvider?.providerName ?? '',
                    meterNumber: _meterNumberController.text.trim(),
                    customerName: _validationResult?.customerName ?? '',
                    customerAddress: _validationResult?.customerAddress,
                    phoneNumber: _phoneController.text.trim().isNotEmpty
                        ? _phoneController.text.trim()
                        : null,
                    meterType: _selectedMeterType,
                    nickname: _nicknameController.text.trim(),
                    isDefault: _setAsDefault,
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now(),
                  );
                  // Pop back to beneficiaries list, then it pops back to home with result
                  Get.back(result: beneficiary);
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF4E03D0), Color(0xFF7C3AED)],
                    ),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.payment, color: Colors.white, size: 22.sp),
                      SizedBox(width: 10.w),
                      Text(
                        'Proceed to Payment',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            // Back to beneficiaries button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(ctx).pop();
                  Get.back(); // Go back to beneficiaries list
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.bookmark_border, color: Colors.white, size: 22.sp),
                      SizedBox(width: 10.w),
                      Text(
                        'Back to Beneficiaries',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(ctx).padding.bottom + 20.h),
          ],
        ),
      ),
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
                        if (state is ProvidersLoaded) {
                          setState(() {
                            _providers = state.providers;
                          });
                        }

                        if (state is SmartMeterValidated) {
                          setState(() {
                            _onSmartValidationSuccess(state.result);
                          });
                          Get.snackbar(
                            'Success',
                            'Meter validated successfully',
                            backgroundColor: Colors.green.withValues(alpha: 0.9),
                            colorText: Colors.white,
                          );
                        }

                        if (state is SmartMeterValidationFailed) {
                          setState(() {
                            _isValidated = false;
                            _validationResult = null;
                            _useSmartLookup = false;
                          });
                          Get.snackbar(
                            'Smart Lookup Failed',
                            '${state.message}. Switched to manual entry.',
                            backgroundColor: Colors.orange.withValues(alpha: 0.9),
                            colorText: Colors.white,
                          );
                        }

                        if (state is MeterValidated) {
                          setState(() {
                            _validationResult = state.validationResult;
                            _isValidated = true;
                          });
                          Get.snackbar(
                            'Success',
                            'Meter validated successfully',
                            backgroundColor: Colors.green.withValues(alpha: 0.9),
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
                            backgroundColor: Colors.red.withValues(alpha: 0.9),
                            colorText: Colors.white,
                          );
                        }
                      },
                    ),
                    BlocListener<BeneficiaryCubit, BeneficiaryState>(
                      listener: (context, state) {
                        if (state is BeneficiarySaved) {
                          _showBeneficiarySavedSheet();
                        }

                        if (state is BeneficiaryError) {
                          Get.snackbar(
                            'Error',
                            state.message,
                            backgroundColor: Colors.red.withValues(alpha: 0.9),
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
                        _buildLookupModeToggle(),
                        SizedBox(height: 24.h),
                        if (!_useSmartLookup) ...[
                          _buildProviderSelector(),
                          SizedBox(height: 24.h),
                          _buildMeterTypeSelector(),
                          SizedBox(height: 24.h),
                        ],
                        _buildMeterNumberInput(),
                        SizedBox(height: 24.h),
                        _buildValidateButton(),
                        if (_isValidated && _validationResult != null) ...[
                          SizedBox(height: 24.h),
                          _buildValidationResult(),
                          SizedBox(height: 24.h),
                          _buildNicknameInput(),
                          SizedBox(height: 16.h),
                          _buildPhoneInput(),
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
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(22.r),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.2),
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
                    color: Colors.white.withValues(alpha: 0.6),
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

  Widget _buildLookupModeToggle() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (!_useSmartLookup) {
                  setState(() {
                    _useSmartLookup = true;
                    _isValidated = false;
                    _validationResult = null;
                  });
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 14.h),
                decoration: BoxDecoration(
                  color: _useSmartLookup
                      ? const Color(0xFF4E03D0)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search,
                      color: _useSmartLookup
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.5),
                      size: 18.sp,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Smart Lookup',
                      style: GoogleFonts.inter(
                        color: _useSmartLookup
                            ? Colors.white
                            : Colors.white.withValues(alpha: 0.5),
                        fontSize: 14.sp,
                        fontWeight: _useSmartLookup ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (_useSmartLookup) {
                  setState(() {
                    _useSmartLookup = false;
                    _isValidated = false;
                    _validationResult = null;
                  });
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 14.h),
                decoration: BoxDecoration(
                  color: !_useSmartLookup
                      ? const Color(0xFF4E03D0)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.list,
                      color: !_useSmartLookup
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.5),
                      size: 18.sp,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Manual Entry',
                      style: GoogleFonts.inter(
                        color: !_useSmartLookup
                            ? Colors.white
                            : Colors.white.withValues(alpha: 0.5),
                        fontSize: 14.sp,
                        fontWeight: !_useSmartLookup ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProviderSelector() {
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
        GestureDetector(
          onTap: _showProviderBottomSheet,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: _selectedProvider != null
                    ? const Color(0xFF4E03D0).withValues(alpha: 0.4)
                    : Colors.white.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                if (_selectedProvider != null) ...[
                  Container(
                    width: 32.w,
                    height: 32.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4E03D0).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      Icons.bolt,
                      color: const Color(0xFF4E03D0),
                      size: 18.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      _selectedProvider!.providerName,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ] else
                  Expanded(
                    child: Text(
                      'Choose electricity provider',
                      style: GoogleFonts.inter(
                        color: Colors.white.withValues(alpha: 0.5),
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white.withValues(alpha: 0.6),
                  size: 24.sp,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showProviderBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        final searchController = TextEditingController();
        return StatefulBuilder(
          builder: (context, setSheetState) {
            final query = searchController.text.toLowerCase();
            final filteredProviders = query.isEmpty
                ? _providers
                : _providers
                    .where((p) =>
                        p.providerName.toLowerCase().contains(query) ||
                        p.providerCode.toLowerCase().contains(query))
                    .toList();

            return Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.7,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A3E),
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(24.r)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 12.h),
                  Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Select Provider',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(ctx).pop(),
                          child: Icon(
                            Icons.close,
                            color: Colors.white.withValues(alpha: 0.6),
                            size: 22.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.1),
                          width: 1,
                        ),
                      ),
                      child: TextField(
                        controller: searchController,
                        autofocus: true,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14.sp,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Search provider...',
                          hintStyle: GoogleFonts.inter(
                            color: Colors.white.withValues(alpha: 0.4),
                            fontSize: 14.sp,
                          ),
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.search,
                            color: Colors.white.withValues(alpha: 0.4),
                            size: 20.sp,
                          ),
                          suffixIcon: searchController.text.isNotEmpty
                              ? GestureDetector(
                                  onTap: () {
                                    searchController.clear();
                                    setSheetState(() {});
                                  },
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white.withValues(alpha: 0.4),
                                    size: 18.sp,
                                  ),
                                )
                              : null,
                        ),
                        onChanged: (_) => setSheetState(() {}),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  if (_providers.isEmpty)
                    Padding(
                      padding: EdgeInsets.all(40.w),
                      child: Column(
                        children: [
                          SizedBox(
                            width: 32.w,
                            height: 32.w,
                            child: const CircularProgressIndicator(
                              color: Color(0xFF4E03D0),
                              strokeWidth: 3,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'Loading providers...',
                            style: GoogleFonts.inter(
                              color: Colors.white.withValues(alpha: 0.6),
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    )
                  else if (filteredProviders.isEmpty)
                    Padding(
                      padding: EdgeInsets.all(40.w),
                      child: Column(
                        children: [
                          Icon(
                            Icons.search_off,
                            color: Colors.white.withValues(alpha: 0.4),
                            size: 40.sp,
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            'No providers found',
                            style: GoogleFonts.inter(
                              color: Colors.white.withValues(alpha: 0.6),
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        itemCount: filteredProviders.length,
                        itemBuilder: (context, index) {
                          final provider = filteredProviders[index];
                          final isSelected =
                              _selectedProvider?.providerCode ==
                                  provider.providerCode;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedProvider = provider;
                                _isValidated = false;
                                _validationResult = null;
                              });
                              Navigator.of(ctx).pop();
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 8.h),
                              padding: EdgeInsets.all(14.w),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFF4E03D0)
                                        .withValues(alpha: 0.2)
                                    : Colors.white.withValues(alpha: 0.05),
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: isSelected
                                      ? const Color(0xFF4E03D0)
                                      : Colors.white
                                          .withValues(alpha: 0.1),
                                  width: isSelected ? 2 : 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 40.w,
                                    height: 40.w,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF4E03D0)
                                          .withValues(alpha: 0.15),
                                      borderRadius:
                                          BorderRadius.circular(10.r),
                                    ),
                                    child: Icon(
                                      Icons.bolt,
                                      color: const Color(0xFF4E03D0),
                                      size: 22.sp,
                                    ),
                                  ),
                                  SizedBox(width: 14.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          provider.providerName,
                                          style: GoogleFonts.inter(
                                            color: Colors.white,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: 2.h),
                                        Text(
                                          provider.providerCode,
                                          style: GoogleFonts.inter(
                                            color: Colors.white
                                                .withValues(alpha: 0.6),
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (isSelected)
                                    Icon(
                                      Icons.check_circle,
                                      color: const Color(0xFF4E03D0),
                                      size: 22.sp,
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  SizedBox(
                      height: MediaQuery.of(ctx).padding.bottom + 16.h),
                ],
              ),
            );
          },
        );
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
              ? const Color(0xFF4E03D0).withValues(alpha: 0.2)
              : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF4E03D0) : Colors.white.withValues(alpha: 0.1),
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xFF4E03D0) : Colors.white.withValues(alpha: 0.6),
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              label,
              style: GoogleFonts.inter(
                color: isSelected ? const Color(0xFF4E03D0) : Colors.white.withValues(alpha: 0.8),
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
        if (_useSmartLookup) ...[
          SizedBox(height: 4.h),
          Text(
            'Enter your meter number and we\'ll auto-detect the provider',
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.4),
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
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
                color: Colors.white.withValues(alpha: 0.3),
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
        final isLoading = state is MeterValidating || state is SmartMeterValidating;

        return GestureDetector(
          onTap: isLoading
              ? null
              : (_useSmartLookup ? _smartValidateMeter : _validateMeter),
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
                    _useSmartLookup ? 'Look Up Meter' : 'Validate Meter',
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
          if (_selectedProvider != null)
            _buildResultRow('Provider', _selectedProvider!.providerName),
          _buildResultRow('Meter Type', _selectedMeterType.displayName),
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
                color: Colors.white.withValues(alpha: 0.8),
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
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
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
                color: Colors.white.withValues(alpha: 0.3),
                fontSize: 16.sp,
              ),
              border: InputBorder.none,
            ),
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
          'Phone Number (Optional)',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          'Used to prefill phone on payment page',
          style: GoogleFonts.inter(
            color: Colors.white.withValues(alpha: 0.4),
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
          child: TextField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: 'Phone number for token delivery',
              hintStyle: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.3),
                fontSize: 16.sp,
              ),
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.phone,
                color: Colors.white.withValues(alpha: 0.4),
                size: 20.sp,
              ),
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
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.1),
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
                      : Colors.white.withValues(alpha: 0.3),
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
