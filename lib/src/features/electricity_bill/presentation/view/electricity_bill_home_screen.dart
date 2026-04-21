import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/provider_entity.dart';
import '../../domain/entities/beneficiary_entity.dart';
import '../../domain/entities/bill_payment_entity.dart';
import '../../domain/repositories/electricity_bill_repository.dart';
import '../../../../../core/types/app_routes.dart';
import '../cubit/electricity_bill_cubit.dart';
import '../cubit/electricity_bill_state.dart';
import '../cubit/beneficiary_cubit.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/core/theme/invoice_theme_colors.dart';
import '../../utils/meter_validation.dart';
import '../../../../../core/widgets/bill_history_item.dart';
import '../widgets/electricity_history_actions_sheet.dart';

class ElectricityBillHomeScreen extends StatefulWidget {
  const ElectricityBillHomeScreen({super.key});

  @override
  State<ElectricityBillHomeScreen> createState() =>
      _ElectricityHomeScreenState();
}

class _ElectricityHomeScreenState extends State<ElectricityBillHomeScreen> {
  final TextEditingController _meterNumberController = TextEditingController();
  MeterType _selectedMeterType = MeterType.prepaid;
  ElectricityProviderEntity? _selectedProvider;
  bool _isValidating = false;
  bool _isSmartValidating = false;
  bool _useSmartLookup = true;
  List<ElectricityProviderEntity> _providers = [];
  String? _beneficiaryPhoneNumber;
  List<BillPaymentEntity> _recentPayments = [];

  @override
  void initState() {
    super.initState();
    context.read<ElectricityBillCubit>().getProviders(country: serviceLocator<LocaleManager>().currentCountry);
    context.read<BeneficiaryCubit>().getBeneficiaries();
    _loadRecentPayments();
  }

  void _loadRecentPayments() {
    context.read<ElectricityBillCubit>().getPaymentHistory(limit: 3, offset: 0);
  }

  @override
  void dispose() {
    _meterNumberController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    context.read<ElectricityBillCubit>().getProviders(country: serviceLocator<LocaleManager>().currentCountry);
    context.read<BeneficiaryCubit>().getBeneficiaries();
    _loadRecentPayments();
  }

  void _prefillFromBeneficiary(BillBeneficiaryEntity beneficiary) {
    final matchingProvider = _providers
        .where((p) => p.providerCode == beneficiary.providerCode)
        .firstOrNull;
    if (matchingProvider != null) {
      setState(() {
        _meterNumberController.text = beneficiary.meterNumber;
        _selectedMeterType = beneficiary.meterType;
        _selectedProvider = matchingProvider;
        _beneficiaryPhoneNumber = beneficiary.phoneNumber;
      });
      context.read<ElectricityBillCubit>().validateMeter(
            providerCode: matchingProvider.providerCode,
            meterNumber: beneficiary.meterNumber,
            meterType: beneficiary.meterType,
          );
    }
  }

  void _smartValidate() {
    final err = validateMeterNumber(_meterNumberController.text);
    if (err != null) {
      Get.snackbar(
        'Invalid Meter Number',
        err,
        backgroundColor: InvoiceThemeColors.errorRed,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    context.read<ElectricityBillCubit>().smartValidateMeter(
          meterNumber: _meterNumberController.text.trim(),
        );
  }

  void _validateMeterManual() {
    if (_selectedProvider == null) {
      Get.snackbar(
        'Select Provider',
        'Please select your electricity distribution company',
        backgroundColor: InvoiceThemeColors.warningOrange,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    final err = validateMeterNumber(_meterNumberController.text);
    if (err != null) {
      Get.snackbar(
        'Invalid Meter Number',
        err,
        backgroundColor: InvoiceThemeColors.errorRed,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    context.read<ElectricityBillCubit>().validateMeter(
          providerCode: _selectedProvider!.providerCode,
          meterNumber: _meterNumberController.text.trim(),
          meterType: _selectedMeterType,
        );
  }

  void _showSmartValidationResult(SmartMeterValidationResult result) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => _SmartValidationBottomSheet(
        result: result,
        providers: _providers,
        onConfirm: () {
          Navigator.of(ctx).pop();
          _navigateToConfirmation(result);
        },
      ),
    );
  }

  void _navigateToConfirmation(SmartMeterValidationResult result) {
    final provider = _providers
        .where((p) => p.providerCode == result.providerCode)
        .firstOrNull;

    final validationResult = MeterValidationResult(
      customerName: result.customerName,
      customerAddress: result.customerAddress,
      meterNumber: result.meterNumber,
      meterType: MeterTypeExtension.fromString(result.meterType),
      isValid: true,
    );

    final providerEntity = provider ??
        ElectricityProviderEntity(
          id: '',
          providerCode: result.providerCode,
          providerName: result.providerName,
          country: serviceLocator<LocaleManager>().currentCountry,
          isActive: true,
          minAmount: result.minAmount,
          maxAmount: result.maxAmount,
          serviceFee: result.serviceFee,
          supportsPrepaid: true,
          supportsPostpaid: true,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

    Get.toNamed(
      AppRoutes.electricityBillConfirmation,
      arguments: {
        'provider': providerEntity,
        'validationResult': validationResult,
        'providerCode': result.providerCode,
        'meterNumber': result.meterNumber,
        'meterType': MeterTypeExtension.fromString(result.meterType),
        'phoneNumber': '',
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1A1A3E),
              Color(0xFF0A0E27),
              Color(0xFF0F0F23),
            ],
          ),
        ),
        child: SafeArea(
          child: BlocConsumer<ElectricityBillCubit, ElectricityBillState>(
            listener: (context, state) {
              if (state is ProvidersLoaded) {
                setState(() {
                  _providers = state.providers;
                  if (_selectedProvider != null) {
                    final match = _providers
                        .where((p) =>
                            p.providerCode == _selectedProvider!.providerCode)
                        .firstOrNull;
                    _selectedProvider =
                        match ?? (_providers.isNotEmpty ? _providers.first : null);
                  }
                });
              }

              if (state is MeterValidating) {
                setState(() => _isValidating = true);
              } else if (_isValidating && state is! MeterValidating) {
                setState(() => _isValidating = false);
              }

              if (state is MeterValidated) {
                Get.toNamed(
                  AppRoutes.electricityBillConfirmation,
                  arguments: {
                    'provider': _selectedProvider,
                    'validationResult': state.validationResult,
                    'providerCode': state.providerCode,
                    'meterNumber': state.meterNumber,
                    'meterType': state.meterType,
                    'phoneNumber': _beneficiaryPhoneNumber ?? '',
                  },
                );
                _beneficiaryPhoneNumber = null;
              }

              if (state is MeterValidationFailed) {
                Get.snackbar(
                  'Validation Failed',
                  state.message,
                  backgroundColor: InvoiceThemeColors.errorRed,
                  colorText: Colors.white,
                  snackPosition: SnackPosition.TOP,
                );
              }

              if (state is SmartMeterValidating) {
                setState(() => _isSmartValidating = true);
              } else if (_isSmartValidating && state is! SmartMeterValidating) {
                setState(() => _isSmartValidating = false);
              }

              if (state is SmartMeterValidated) {
                _showSmartValidationResult(state.result);
              }

              if (state is SmartMeterValidationFailed) {
                Get.snackbar(
                  'Meter Not Found',
                  state.message,
                  backgroundColor: InvoiceThemeColors.warningOrange,
                  colorText: Colors.white,
                  snackPosition: SnackPosition.TOP,
                  duration: const Duration(seconds: 4),
                );
                setState(() => _useSmartLookup = false);
              }

              if (state is ElectricityBillError) {
                Get.snackbar(
                  'Error',
                  state.message,
                  backgroundColor: InvoiceThemeColors.errorRed,
                  colorText: Colors.white,
                  snackPosition: SnackPosition.TOP,
                );
              }

              if (state is PaymentHistoryLoaded) {
                setState(() {
                  _recentPayments = state.payments.take(3).toList();
                });
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  _buildCompactHeader(),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: _onRefresh,
                      color: InvoiceThemeColors.primaryPurple,
                      backgroundColor: const Color(0xFF1F1F1F),
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 12.h),
                            _buildWelcomeCard(),
                            SizedBox(height: 20.h),
                            _buildQuickActions(),
                            SizedBox(height: 20.h),
                            _buildMeterInputSection(state),
                            SizedBox(height: 20.h),
                            if (_recentPayments.isNotEmpty) ...[
                              SizedBox(height: 20.h),
                              _buildRecentPaymentsSection(),
                            ],
                            SizedBox(height: 32.h),
                          ],
                        ),
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

  Widget _buildCompactHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.offAllNamed(AppRoutes.billsHub),
            child: Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F).withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 16.sp,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'Electricity',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            InvoiceThemeColors.primaryPurple,
            Color.fromARGB(255, 62, 2, 166),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.3),
            blurRadius: 20.r,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.bolt,
                  color: Colors.white,
                  size: 22.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pay Electricity Bills',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Fast, secure, and reliable',
                      style: GoogleFonts.inter(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Expanded(
            child: _buildQuickActionCard(
              title: 'Saved Meters',
              icon: Icons.bookmark_border,
              color: InvoiceThemeColors.primaryPurple,
              onTap: () async {
                final result = await Get.toNamed(
                  AppRoutes.electricityBillBeneficiaries,
                  arguments: {'providers': _providers},
                );
                if (result is BillBeneficiaryEntity) {
                  _prefillFromBeneficiary(result);
                }
              },
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: _buildQuickActionCard(
              title: 'Auto-Recharge',
              icon: Icons.autorenew,
              color: const Color(0xFF10B981),
              onTap: () =>
                  Get.toNamed(AppRoutes.electricityBillAutoRecharge),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: _buildQuickActionCard(
              title: 'Reminders',
              icon: Icons.notifications_outlined,
              color: const Color(0xFFF59E0B),
              onTap: () =>
                  Get.toNamed(AppRoutes.electricityBillReminders),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F).withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: const Color(0xFF2D2D2D).withValues(alpha: 0.5),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                icon,
                color: color,
                size: 18.sp,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMeterInputSection(ElectricityBillState state) {
    final isLoading = state is ElectricityBillLoading;

    if (isLoading) {
      return _buildLoadingShimmer();
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLookupModeToggle(),
          SizedBox(height: 16.h),

          if (!_useSmartLookup) ...[
            _buildProviderDropdown(),
            SizedBox(height: 12.h),
            _buildMeterTypeSelector(),
            SizedBox(height: 12.h),
          ],

          _buildMeterNumberInput(),
          SizedBox(height: 20.h),

          if (_useSmartLookup)
            _buildSmartValidateButton()
          else
            _buildManualValidateButton(),
        ],
      ),
    );
  }

  Widget _buildLookupModeToggle() {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F).withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: const Color(0xFF2D2D2D).withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (!_useSmartLookup) {
                  setState(() => _useSmartLookup = true);
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                decoration: BoxDecoration(
                  color: _useSmartLookup
                      ? InvoiceThemeColors.primaryPurple
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search,
                      color: _useSmartLookup
                          ? Colors.white
                          : const Color(0xFF6B7280),
                      size: 16.sp,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'Smart',
                      style: GoogleFonts.inter(
                        color: _useSmartLookup
                            ? Colors.white
                            : const Color(0xFF6B7280),
                        fontSize: 13.sp,
                        fontWeight:
                            _useSmartLookup ? FontWeight.w600 : FontWeight.w400,
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
                  setState(() => _useSmartLookup = false);
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                decoration: BoxDecoration(
                  color: !_useSmartLookup
                      ? InvoiceThemeColors.primaryPurple
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.list,
                      color: !_useSmartLookup
                          ? Colors.white
                          : const Color(0xFF6B7280),
                      size: 16.sp,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'Manual',
                      style: GoogleFonts.inter(
                        color: !_useSmartLookup
                            ? Colors.white
                            : const Color(0xFF6B7280),
                        fontSize: 13.sp,
                        fontWeight: !_useSmartLookup
                            ? FontWeight.w600
                            : FontWeight.w400,
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

  Widget _buildMeterNumberInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Meter Number',
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F).withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: const Color(0xFF2D2D2D).withValues(alpha: 0.5),
                width: 1,
              ),
            ),
            child: TextField(
              controller: _meterNumberController,
              keyboardType: TextInputType.number,
              // Digits-only + hard length cap = the user can't type past
              // the NG standard, and paste gets stripped of letters/
              // spaces. Pair with the inline error below for the min-len
              // side (typed < 10 chars).
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(kMeterNumberMaxLen),
              ],
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText:
                    '$kMeterNumberMinLen–$kMeterNumberMaxLen digit meter number',
                hintStyle: GoogleFonts.inter(
                  color: const Color(0xFF6B7280),
                  fontSize: 14.sp,
                ),
                border: InputBorder.none,
                icon: Icon(
                  Icons.numbers,
                  color: const Color(0xFF6B7280),
                  size: 20.sp,
                ),
                suffixIcon: _meterNumberController.text.isNotEmpty
                    ? GestureDetector(
                      onTap: () {
                        _meterNumberController.clear();
                        setState(() {});
                      },
                      child: Icon(
                        Icons.close,
                        color: const Color(0xFF6B7280),
                        size: 18.sp,
                      ),
                    )
                    : null,
              ),
              onChanged: (_) => setState(() {}),
            ),
          ),
          // Live inline error when the user has typed something but it's
          // still short of the min length. Empty state shows no error so
          // we don't nag on a fresh field.
          if (_meterNumberController.text.trim().isNotEmpty &&
              validateMeterNumber(_meterNumberController.text) != null) ...[
            SizedBox(height: 6.h),
            Text(
              validateMeterNumber(_meterNumberController.text)!,
              style: GoogleFonts.inter(
                color: const Color(0xFFEF4444),
                fontSize: 11.sp,
              ),
            ),
          ],
        ],
      );
  }

  Widget _buildSmartValidateButton() {
    final isReady = _meterNumberController.text.trim().isNotEmpty;
    final isLoading = _isSmartValidating || _isValidating;

    return GestureDetector(
      onTap: isLoading || !isReady ? null : _smartValidate,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          gradient: !isReady || isLoading
              ? null
              : const LinearGradient(
                  colors: [
            InvoiceThemeColors.primaryPurple,
            Color.fromARGB(255, 62, 2, 166),
          ],
                ),
          color: !isReady || isLoading
              ? const Color(0xFF1F1F1F)
              : null,
          borderRadius: BorderRadius.circular(12.r),
          border: !isReady
              ? Border.all(color: const Color(0xFF2D2D2D))
              : null,
        ),
        child: isLoading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 18.w,
                    height: 18.w,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'Looking up...',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search,
                    color: isReady ? Colors.white : const Color(0xFF6B7280),
                    size: 20.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Look Up Meter',
                    style: GoogleFonts.inter(
                      color: isReady ? Colors.white : const Color(0xFF6B7280),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildProviderDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Electricity Provider',
          style: GoogleFonts.inter(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: _showProviderBottomSheet,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F).withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: _selectedProvider != null
                    ? InvoiceThemeColors.primaryPurple.withValues(alpha: 0.4)
                    : const Color(0xFF2D2D2D).withValues(alpha: 0.5),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                if (_selectedProvider != null) ...[
                  Container(
                    width: 28.w,
                    height: 28.w,
                    decoration: BoxDecoration(
                      color: _getProviderColor(_selectedProvider!)
                          .withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      Icons.bolt,
                      color: _getProviderColor(_selectedProvider!),
                      size: 16.sp,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _selectedProvider!.providerName,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          _selectedProvider!.providerCode,
                          style: GoogleFonts.inter(
                            color: const Color(0xFF9CA3AF),
                            fontSize: 11.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ] else
                  Expanded(
                    child: Text(
                      'Select provider',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF6B7280),
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: const Color(0xFF9CA3AF),
                  size: 20.sp,
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
                maxHeight: MediaQuery.of(context).size.height * 0.65,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(20.r)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 10.h),
                  Container(
                    width: 32.w,
                    height: 3.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2D2D2D),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Select Provider',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(ctx).pop(),
                          child: Icon(
                            Icons.close,
                            color: const Color(0xFF9CA3AF),
                            size: 20.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  if (_providers.isEmpty)
                    Padding(
                      padding: EdgeInsets.all(32.w),
                      child: Column(
                        children: [
                          SizedBox(
                            width: 28.w,
                            height: 28.w,
                            child: const CircularProgressIndicator(
                              color: InvoiceThemeColors.primaryPurple,
                              strokeWidth: 2.5,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            'Loading providers...',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF9CA3AF),
                              fontSize: 13.sp,
                            ),
                          ),
                        ],
                      ),
                    )
                  else if (filteredProviders.isEmpty)
                    Padding(
                      padding: EdgeInsets.all(32.w),
                      child: Column(
                        children: [
                          Icon(
                            Icons.search_off,
                            color: const Color(0xFF6B7280),
                            size: 32.sp,
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            'No providers found',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF9CA3AF),
                              fontSize: 13.sp,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        itemCount: filteredProviders.length,
                        itemBuilder: (context, index) {
                          final provider = filteredProviders[index];
                          final isSelected = _selectedProvider?.providerCode ==
                              provider.providerCode;
                          final color = _getProviderColor(provider);

                          return GestureDetector(
                            onTap: () {
                              setState(() => _selectedProvider = provider);
                              Navigator.of(ctx).pop();
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 6.h),
                              padding: EdgeInsets.all(12.w),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? InvoiceThemeColors.primaryPurple
                                        .withValues(alpha: 0.12)
                                    : const Color(0xFF0A0A0A),
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(
                                  color: isSelected
                                      ? InvoiceThemeColors.primaryPurple
                                      : const Color(0xFF2D2D2D),
                                  width: isSelected ? 1.5 : 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 32.w,
                                    height: 32.w,
                                    decoration: BoxDecoration(
                                      color: color.withValues(alpha: 0.15),
                                      borderRadius:
                                          BorderRadius.circular(8.r),
                                    ),
                                    child: Icon(
                                      Icons.bolt,
                                      color: color,
                                      size: 18.sp,
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          provider.providerName,
                                          style: GoogleFonts.inter(
                                            color: Colors.white,
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 2.h),
                                        Text(
                                          provider.providerCode,
                                          style: GoogleFonts.inter(
                                            color: const Color(0xFF9CA3AF),
                                            fontSize: 11.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (isSelected)
                                    Icon(
                                      Icons.check_circle,
                                      color: InvoiceThemeColors.primaryPurple,
                                      size: 18.sp,
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  SizedBox(
                    height: MediaQuery.of(ctx).padding.bottom + 12.h,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Color _getProviderColor(ElectricityProviderEntity provider) {
    const colors = [
      InvoiceThemeColors.primaryPurple,
      InvoiceThemeColors.successGreen,
      InvoiceThemeColors.warningOrange,
      Color.fromARGB(255, 78, 3, 208),
      InvoiceThemeColors.errorRed,
      Color.fromARGB(255, 124, 58, 237),
    ];
    final colorIndex = provider.providerCode.hashCode.abs() % colors.length;
    return colors[colorIndex];
  }

  Widget _buildMeterTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Meter Type',
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(
                child: _buildMeterTypeOption(
                  MeterType.prepaid,
                  'Prepaid',
                  Icons.payment,
                ),
              ),
              SizedBox(width: 10.w),
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
        setState(() => _selectedMeterType = type);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 14.w),
        decoration: BoxDecoration(
          color: isSelected
              ? InvoiceThemeColors.primaryPurple.withValues(alpha: 0.12)
              : const Color(0xFF1F1F1F).withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: isSelected
                ? InvoiceThemeColors.primaryPurple
                : const Color(0xFF2D2D2D).withValues(alpha: 0.5),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected
                  ? InvoiceThemeColors.primaryPurple
                  : const Color(0xFF6B7280),
              size: 18.sp,
            ),
            SizedBox(width: 6.w),
            Text(
              label,
              style: GoogleFonts.inter(
                color: isSelected ? Colors.white : const Color(0xFF9CA3AF),
                fontSize: 13.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildManualValidateButton() {
    final isReady = _selectedProvider != null &&
        _meterNumberController.text.trim().isNotEmpty;

    return GestureDetector(
      onTap: _isValidating || !isReady ? null : _validateMeterManual,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          gradient: !isReady || _isValidating
              ? null
              : const LinearGradient(
                  colors: [
            InvoiceThemeColors.primaryPurple,
            Color.fromARGB(255, 62, 2, 166),
          ],
                ),
          color: !isReady || _isValidating
              ? const Color(0xFF1F1F1F)
              : null,
          borderRadius: BorderRadius.circular(12.r),
          border: !isReady
              ? Border.all(color: const Color(0xFF2D2D2D))
              : null,
        ),
        child: _isValidating
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 18.w,
                    height: 18.w,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'Validating...',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    color: isReady ? Colors.white : const Color(0xFF6B7280),
                    size: 20.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Continue',
                    style: GoogleFonts.inter(
                      color: isReady ? Colors.white : const Color(0xFF6B7280),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildRecentPaymentsSection() {
    // Split display: header row with purple View-All, then each recent
    // payment gets its own standalone card — same visual treatment the
    // full history screen uses — with spacing between rows.
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Payments',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: () =>
                    Get.toNamed(AppRoutes.electricityBillHistory),
                child: Text(
                  'View All',
                  style: GoogleFonts.inter(
                    color: InvoiceThemeColors.primaryPurple,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          ..._recentPayments.take(3).map(
                (payment) => Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: InvoiceThemeColors.secondaryBackground,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: _buildPaymentCard(payment),
                  ),
                ),
              ),
        ],
      ),
    );
  }

  Widget _buildPaymentCard(BillPaymentEntity payment) {
    // Compact `BillHistoryItem` row — same shared widget the internet
    // recent-transactions strip uses, same tap-opens-actions-sheet UX.
    const accent = InvoiceThemeColors.primaryPurple;
    return BillHistoryItem(
      compact: true,
      leadingIcon: Container(
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Center(
          child: Icon(Icons.electric_bolt, color: accent, size: 16.sp),
        ),
      ),
      title: payment.providerName,
      subtitle: [
        payment.meterNumber,
        if (payment.meterType.name.isNotEmpty) payment.meterType.name,
        _formatDate(payment.createdAt),
      ].where((s) => s.isNotEmpty).join(' \u00B7 '),
      amount: payment.amount,
      currencySymbol: '\u20A6',
      // `displayStatus` already collapses failed-but-refunded to
      // "Refunded" so the compact strip on the landing reads the same
      // as the receipt screen's hero — a plain "Failed" on a row where
      // the money came back would be worse than mildly misleading.
      status: payment.displayStatus,
      refundSource: payment.refundSource,
      onTap: () => ElectricityHistoryActionsSheet.show(context, payment),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        final mins = difference.inMinutes;
        if (mins == 0) return 'Just now';
        return '$mins min${mins > 1 ? 's' : ''} ago';
      }
      return '${difference.inHours} hr${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  Widget _buildLoadingShimmer() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 180.w,
            height: 20.h,
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F).withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            width: double.infinity,
            height: 48.h,
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F).withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            width: double.infinity,
            height: 48.h,
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F).withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
        ],
      ),
    );
  }
}

/// Bottom sheet showing smart validation results for confirmation
class _SmartValidationBottomSheet extends StatelessWidget {
  final SmartMeterValidationResult result;
  final List<ElectricityProviderEntity> providers;
  final VoidCallback onConfirm;

  const _SmartValidationBottomSheet({
    required this.result,
    required this.providers,
    required this.onConfirm,
  });

  Color _getProviderColor() {
    const colors = [
      InvoiceThemeColors.primaryPurple,
      InvoiceThemeColors.successGreen,
      InvoiceThemeColors.warningOrange,
      Color.fromARGB(255, 78, 3, 208),
      InvoiceThemeColors.errorRed,
      Color.fromARGB(255, 124, 58, 237),
    ];
    final colorIndex = result.providerCode.hashCode.abs() % colors.length;
    return colors[colorIndex];
  }

  @override
  Widget build(BuildContext context) {
    final providerColor = _getProviderColor();

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10.h),
          Container(
            width: 32.w,
            height: 3.h,
            decoration: BoxDecoration(
              color: const Color(0xFF2D2D2D),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 20.h),

          // Success icon
          Container(
            width: 56.w,
            height: 56.w,
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_circle,
              color: const Color(0xFF10B981),
              size: 28.sp,
            ),
          ),
          SizedBox(height: 12.h),

          Text(
            'Meter Found',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 20.h),

          // Details card
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF0A0A0A),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: const Color(0xFF2D2D2D)),
            ),
            child: Column(
              children: [
                _buildDetailRow(
                  'Customer Name',
                  result.customerName,
                  Icons.person_outline,
                ),
                if (result.customerAddress != null &&
                    result.customerAddress!.isNotEmpty) ...[
                  SizedBox(height: 10.h),
                  _buildDetailRow(
                    'Address',
                    result.customerAddress!,
                    Icons.location_on_outlined,
                  ),
                ],
                SizedBox(height: 10.h),
                _buildDetailRow(
                  'Meter Number',
                  result.meterNumber,
                  Icons.numbers,
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Expanded(
                      child: _buildDetailRow(
                        'Provider',
                        result.providerName,
                        Icons.bolt,
                        valueColor: providerColor,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 3.h,
                      ),
                      decoration: BoxDecoration(
                        color: providerColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        result.meterType.toUpperCase(),
                        style: GoogleFonts.inter(
                          color: providerColor,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),

          // Confirm button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: GestureDetector(
              onTap: onConfirm,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
            InvoiceThemeColors.primaryPurple,
            Color.fromARGB(255, 62, 2, 166),
          ],
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Confirm & Continue',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: MediaQuery.of(context).padding.bottom + 16.h),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value,
    IconData icon, {
    Color? valueColor,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(0xFF9CA3AF),
          size: 16.sp,
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                value,
                style: GoogleFonts.inter(
                  color: valueColor ?? Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
