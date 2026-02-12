import 'package:flutter/material.dart';
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
import '../cubit/beneficiary_state.dart';
import 'package:lazervault/src/features/widgets/service_voice_button.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/microservice_chat_icon.dart';

class ElectricityBillHomeScreen extends StatefulWidget {
  const ElectricityBillHomeScreen({super.key});

  @override
  State<ElectricityBillHomeScreen> createState() =>
      _ElectricityBillHomeScreenState();
}

class _ElectricityBillHomeScreenState extends State<ElectricityBillHomeScreen> {
  final TextEditingController _meterNumberController = TextEditingController();
  MeterType _selectedMeterType = MeterType.prepaid;
  ElectricityProviderEntity? _selectedProvider;
  bool _isValidating = false;
  bool _isSmartValidating = false;
  bool _showManualMode = false;
  List<ElectricityProviderEntity> _providers = [];

  @override
  void initState() {
    super.initState();
    context.read<ElectricityBillCubit>().getProviders(country: 'NG');
    context.read<BeneficiaryCubit>().getBeneficiaries();
  }

  @override
  void dispose() {
    _meterNumberController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    context.read<ElectricityBillCubit>().getProviders(country: 'NG');
    context.read<BeneficiaryCubit>().getBeneficiaries();
  }

  void _prefillFromBeneficiary(BillBeneficiaryEntity beneficiary) {
    // Beneficiary already knows DISCO + type, use direct validation
    final matchingProvider = _providers
        .where((p) => p.providerCode == beneficiary.providerCode)
        .firstOrNull;
    if (matchingProvider != null) {
      setState(() {
        _meterNumberController.text = beneficiary.meterNumber;
        _selectedMeterType = beneficiary.meterType;
        _selectedProvider = matchingProvider;
      });
      // Direct validate since we know the provider
      context.read<ElectricityBillCubit>().validateMeter(
            providerCode: matchingProvider.providerCode,
            meterNumber: beneficiary.meterNumber,
            meterType: beneficiary.meterType,
          );
    }
  }

  void _smartValidate() {
    final meterNumber = _meterNumberController.text.trim();
    if (meterNumber.isEmpty) {
      Get.snackbar(
        'Enter Meter Number',
        'Please enter your meter number',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    if (meterNumber.length < 11) {
      Get.snackbar(
        'Invalid Meter Number',
        'Meter number must be at least 11 digits',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    context.read<ElectricityBillCubit>().smartValidateMeter(
          meterNumber: meterNumber,
        );
  }

  void _validateMeterManual() {
    if (_selectedProvider == null) {
      Get.snackbar(
        'Select Provider',
        'Please select your electricity distribution company',
        backgroundColor: const Color(0xFFFB923C),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    final meterNumber = _meterNumberController.text.trim();
    if (meterNumber.isEmpty) {
      Get.snackbar(
        'Enter Meter Number',
        'Please enter your meter number',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    if (meterNumber.length < 6) {
      Get.snackbar(
        'Invalid Meter Number',
        'Meter number must be at least 6 digits',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    context.read<ElectricityBillCubit>().validateMeter(
          providerCode: _selectedProvider!.providerCode,
          meterNumber: meterNumber,
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
    // Find the matching provider entity for the confirmation screen
    final provider = _providers
        .where((p) => p.providerCode == result.providerCode)
        .firstOrNull;

    // Build a MeterValidationResult from the smart result
    final validationResult = MeterValidationResult(
      customerName: result.customerName,
      customerAddress: result.customerAddress,
      meterNumber: result.meterNumber,
      meterType: MeterTypeExtension.fromString(result.meterType),
      isValid: true,
    );

    // Build a provider entity if not found in the local list
    final providerEntity = provider ??
        ElectricityProviderEntity(
          id: '',
          providerCode: result.providerCode,
          providerName: result.providerName,
          country: 'NG',
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
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

            // Handle existing direct meter validation
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
                },
              );
            }

            if (state is MeterValidationFailed) {
              Get.snackbar(
                'Validation Failed',
                state.message,
                backgroundColor: const Color(0xFFEF4444),
                colorText: Colors.white,
                snackPosition: SnackPosition.TOP,
              );
            }

            // Handle smart meter validation
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
                backgroundColor: const Color(0xFFFB923C),
                colorText: Colors.white,
                snackPosition: SnackPosition.TOP,
                duration: const Duration(seconds: 4),
              );
              // Auto-show manual mode on failure
              setState(() => _showManualMode = true);
            }

            if (state is ElectricityBillError) {
              Get.snackbar(
                'Error',
                state.message,
                backgroundColor: const Color(0xFFEF4444),
                colorText: Colors.white,
                snackPosition: SnackPosition.TOP,
              );
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: _onRefresh,
                    color: const Color(0xFF3B82F6),
                    backgroundColor: const Color(0xFF1F1F1F),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8.h),
                          _buildSavedBeneficiaries(),
                          SizedBox(height: 20.h),
                          _buildQuickActions(),
                          SizedBox(height: 24.h),
                          _buildMeterInputSection(state),
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
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(22.r),
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
            child: Text(
              'Electricity Bill',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          ServiceVoiceButton(
            serviceName: 'electricity',
          ),
          SizedBox(width: 8.w),
          MicroserviceChatIcon(
            serviceName: 'Utility Payments',
            sourceContext: 'bills',
            icon: Icons.chat_bubble_outline,
            iconColor: const Color(0xFF10B981),
          ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.electricityBillHistory),
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Icon(
                Icons.history,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSavedBeneficiaries() {
    return BlocBuilder<BeneficiaryCubit, BeneficiaryState>(
      builder: (context, state) {
        if (state is BeneficiariesLoaded && state.beneficiaries.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Saved Beneficiaries',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed(
                          AppRoutes.electricityBillBeneficiaries),
                      child: Text(
                        'View All',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF3B82F6),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              SizedBox(
                height: 100.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  itemCount: state.beneficiaries.length,
                  separatorBuilder: (_, __) => SizedBox(width: 12.w),
                  itemBuilder: (context, index) {
                    final beneficiary = state.beneficiaries[index];
                    return _buildBeneficiaryCard(beneficiary);
                  },
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildBeneficiaryCard(BillBeneficiaryEntity beneficiary) {
    return GestureDetector(
      onTap: () => _prefillFromBeneficiary(beneficiary),
      child: Container(
        width: 140.w,
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: beneficiary.isDefault
                ? const Color(0xFF3B82F6).withValues(alpha: 0.4)
                : const Color(0xFF2D2D2D),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  width: 30.w,
                  height: 30.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFB923C).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Icons.bolt,
                    color: const Color(0xFFFB923C),
                    size: 16.sp,
                  ),
                ),
                const Spacer(),
                if (beneficiary.isDefault)
                  Icon(
                    Icons.star,
                    color: const Color(0xFFFB923C),
                    size: 14.sp,
                  ),
              ],
            ),
            SizedBox(height: 10.h),
            Text(
              beneficiary.displayName,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 2.h),
            Text(
              beneficiary.meterNumber,
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 11.sp,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          Expanded(
            child: _buildQuickActionCard(
              title: 'Beneficiaries',
              icon: Icons.bookmark_border,
              color: const Color(0xFF3B82F6),
              onTap: () =>
                  Get.toNamed(AppRoutes.electricityBillBeneficiaries),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: _buildQuickActionCard(
              title: 'Auto-Recharge',
              icon: Icons.autorenew,
              color: const Color(0xFF10B981),
              onTap: () =>
                  Get.toNamed(AppRoutes.electricityBillAutoRecharge),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: _buildQuickActionCard(
              title: 'Reminders',
              icon: Icons.notifications_outlined,
              color: const Color(0xFFFB923C),
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
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
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
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                icon,
                color: color,
                size: 20.sp,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              title,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 12.sp,
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
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Row(
            children: [
              Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.electric_meter,
                  color: const Color(0xFF3B82F6),
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                'Pay Electricity Bill',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Padding(
            padding: EdgeInsets.only(left: 48.w),
            child: Text(
              'Just enter your meter number',
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: 20.h),

          // Meter number input
          _buildMeterNumberInput(),
          SizedBox(height: 24.h),

          // Smart validate button
          _buildSmartValidateButton(),

          // Manual entry fallback
          if (!_showManualMode) ...[
            SizedBox(height: 16.h),
            Center(
              child: GestureDetector(
                onTap: () => setState(() => _showManualMode = true),
                child: Text(
                  'Enter manually instead',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.underline,
                    decorationColor: const Color(0xFF9CA3AF),
                  ),
                ),
              ),
            ),
          ],

          // Manual mode fields
          if (_showManualMode) ...[
            SizedBox(height: 24.h),
            _buildManualModeSection(),
          ],
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
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: const Color(0xFF2D2D2D),
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
                color: const Color(0xFF6B7280),
                fontSize: 16.sp,
              ),
              border: InputBorder.none,
              icon: Icon(
                Icons.numbers,
                color: const Color(0xFF6B7280),
                size: 22.sp,
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
                        size: 20.sp,
                      ),
                    )
                  : null,
            ),
            onChanged: (_) => setState(() {}),
          ),
        ),
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
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          gradient: !isReady || isLoading
              ? null
              : const LinearGradient(
                  colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
                ),
          color: !isReady || isLoading
              ? const Color(0xFF1F1F1F)
              : null,
          borderRadius: BorderRadius.circular(14.r),
          border: !isReady
              ? Border.all(color: const Color(0xFF2D2D2D))
              : null,
        ),
        child: isLoading
            ? Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 20.w,
                        height: 20.w,
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        'Looking up your meter...',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  if (_isSmartValidating) ...[
                    SizedBox(height: 6.h),
                    Text(
                      'Checking all providers, this may take a few seconds',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search,
                    color: isReady ? Colors.white : const Color(0xFF6B7280),
                    size: 22.sp,
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'Look Up Meter',
                    style: GoogleFonts.inter(
                      color: isReady ? Colors.white : const Color(0xFF6B7280),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildManualModeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: 1,
                color: const Color(0xFF2D2D2D),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Text(
                'Manual Entry',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 1,
                color: const Color(0xFF2D2D2D),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),

        // Provider dropdown
        _buildProviderDropdown(),
        SizedBox(height: 16.h),

        // Meter type toggle
        _buildMeterTypeSelector(),
        SizedBox(height: 24.h),

        // Manual validate button
        _buildManualValidateButton(),
      ],
    );
  }

  Widget _buildProviderDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Distribution Company (DisCo)',
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
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: _selectedProvider != null
                  ? const Color(0xFF3B82F6).withValues(alpha: 0.4)
                  : const Color(0xFF2D2D2D),
              width: 1,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<ElectricityProviderEntity>(
              value: _selectedProvider,
              isExpanded: true,
              dropdownColor: const Color(0xFF1F1F1F),
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: const Color(0xFF9CA3AF),
                size: 24.sp,
              ),
              hint: Text(
                'Select your DisCo',
                style: GoogleFonts.inter(
                  color: const Color(0xFF6B7280),
                  fontSize: 15.sp,
                ),
              ),
              items: _providers.map((provider) {
                return DropdownMenuItem<ElectricityProviderEntity>(
                  value: provider,
                  child: Row(
                    children: [
                      Container(
                        width: 32.w,
                        height: 32.w,
                        decoration: BoxDecoration(
                          color: _getProviderColor(provider)
                              .withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(
                          Icons.bolt,
                          color: _getProviderColor(provider),
                          size: 18.sp,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              provider.providerName,
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
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
                    ],
                  ),
                );
              }).toList(),
              onChanged: (provider) {
                setState(() => _selectedProvider = provider);
              },
            ),
          ),
        ),
      ],
    );
  }

  Color _getProviderColor(ElectricityProviderEntity provider) {
    const colors = [
      Color(0xFF3B82F6),
      Color(0xFF10B981),
      Color(0xFFFB923C),
      Color(0xFF8B5CF6),
      Color(0xFFEF4444),
      Color(0xFF06B6D4),
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
            color: Colors.white,
            fontSize: 14.sp,
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
        setState(() => _selectedMeterType = type);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF3B82F6).withValues(alpha: 0.1)
              : const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF3B82F6)
                : const Color(0xFF2D2D2D),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected
                  ? const Color(0xFF3B82F6)
                  : const Color(0xFF6B7280),
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              label,
              style: GoogleFonts.inter(
                color: isSelected ? Colors.white : const Color(0xFF9CA3AF),
                fontSize: 14.sp,
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
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          gradient: !isReady || _isValidating
              ? null
              : const LinearGradient(
                  colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
                ),
          color: !isReady || _isValidating
              ? const Color(0xFF1F1F1F)
              : null,
          borderRadius: BorderRadius.circular(14.r),
          border: !isReady
              ? Border.all(color: const Color(0xFF2D2D2D))
              : null,
        ),
        child: _isValidating
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20.w,
                    height: 20.w,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'Validating Meter...',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
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
                    size: 22.sp,
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'Validate & Continue',
                    style: GoogleFonts.inter(
                      color: isReady ? Colors.white : const Color(0xFF6B7280),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildLoadingShimmer() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 200.w,
            height: 24.h,
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          SizedBox(height: 20.h),
          Container(
            width: double.infinity,
            height: 56.h,
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            width: double.infinity,
            height: 56.h,
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
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
      Color(0xFF3B82F6),
      Color(0xFF10B981),
      Color(0xFFFB923C),
      Color(0xFF8B5CF6),
      Color(0xFFEF4444),
      Color(0xFF06B6D4),
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
              color: const Color(0xFF2D2D2D),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 24.h),

          // Success icon
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
            'Meter Found',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 24.h),

          // Details card
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
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
                  SizedBox(height: 12.h),
                  _buildDetailRow(
                    'Address',
                    result.customerAddress!,
                    Icons.location_on_outlined,
                  ),
                ],
                SizedBox(height: 12.h),
                _buildDetailRow(
                  'Meter Number',
                  result.meterNumber,
                  Icons.numbers,
                ),
                SizedBox(height: 12.h),
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
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: providerColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        result.meterType.toUpperCase(),
                        style: GoogleFonts.inter(
                          color: providerColor,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          // Confirm button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: GestureDetector(
              onTap: onConfirm,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
                  ),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      color: Colors.white,
                      size: 22.sp,
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      'Confirm & Continue',
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

          SizedBox(height: MediaQuery.of(context).padding.bottom + 20.h),
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
          size: 18.sp,
        ),
        SizedBox(width: 10.w),
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
                  fontSize: 14.sp,
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
