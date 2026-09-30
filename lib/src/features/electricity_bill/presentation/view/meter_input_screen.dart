import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/provider_entity.dart';
import '../../domain/entities/bill_payment_entity.dart';
import '../../../../../core/types/app_routes.dart';
import '../cubit/electricity_bill_cubit.dart';
import '../cubit/electricity_bill_state.dart';
import '../../domain/repositories/electricity_bill_repository.dart';
import '../../utils/meter_validation.dart';
import 'meter_entry_mode.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

class MeterInputScreen extends StatefulWidget {
  const MeterInputScreen({super.key});

  @override
  State<MeterInputScreen> createState() => _MeterInputScreenState();
}

class _MeterInputScreenState extends State<MeterInputScreen> {
  final TextEditingController _meterNumberController = TextEditingController();
  MeterType _selectedMeterType = MeterType.prepaid;
  bool _isValidating = false;
  ElectricityProviderEntity? _provider;

  /// Auto asks the disco who the meter belongs to; manual takes the
  /// customer's word for it. See [MeterEntryMode] — the lookup does not
  /// answer for every meter, and a red snackbar was the whole of the old
  /// recovery path.
  MeterEntryMode _mode = MeterEntryMode.auto;

  /// The last lookup failure, shown INLINE with a way out instead of as a
  /// snackbar that takes the reason away after four seconds and leaves the
  /// user on a screen that will not advance.
  String? _lookupError;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args is Map<String, dynamic> &&
        args['provider'] is ElectricityProviderEntity) {
      _provider = args['provider'] as ElectricityProviderEntity;
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.back();
      });
    }
  }

  @override
  void dispose() {
    _meterNumberController.dispose();
    super.dispose();
  }

  void _validateMeter() {
    final provider = _provider;
    if (provider == null) return;
    final err = validateMeterNumber(_meterNumberController.text);
    if (err != null) {
      Get.snackbar(
        'Invalid Meter Number',
        err,
        backgroundColor: Colors.red.withValues(alpha: 0.9),
        colorText: Colors.white,
      );
      return;
    }

    if (_mode.isManual) {
      // No lookup. The customer supplied the disco and the meter, and the
      // confirmation screen will say the name is unconfirmed — which is the
      // honest statement, and the one that makes them check.
      _goToConfirmation(
        provider: provider,
        result: manualMeterResult(
          meterNumber: _meterNumberController.text.trim(),
          meterType: _selectedMeterType,
        ),
      );
      return;
    }

    setState(() => _lookupError = null);
    context.read<ElectricityBillCubit>().validateMeter(
          providerCode: provider.providerCode,
          meterNumber: _meterNumberController.text.trim(),
          meterType: _selectedMeterType,
        );
  }

  void _goToConfirmation({
    required ElectricityProviderEntity provider,
    required MeterValidationResult result,
  }) {
    Get.toNamed(
      AppRoutes.electricityBillConfirmation,
      arguments: {
        'provider': provider,
        'validationResult': result,
        'providerCode': provider.providerCode,
        'meterNumber': result.meterNumber,
        'meterType': result.meterType,
        'entryMode': _mode.name,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = _provider;
    if (provider == null) {
      return const Scaffold(
        backgroundColor: Color(0xFF0A0A0A),
        body: SizedBox.shrink(),
      );
    }

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
                    'entryMode': MeterEntryMode.auto.name,
                  },
                );
              }

              if (state is MeterValidationFailed) {
                // Inline, with the way out attached. A snackbar took the
                // reason away after four seconds and left the user on a
                // screen that would not advance — for a meter that pays
                // perfectly well, because the disco's directory is the thing
                // that is missing, not the customer's account.
                setState(() => _lookupError = state.message);
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
            builder: (context, state) {
              return Column(
                children: [
                  _buildHeader(provider),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(20.w, 20.w, 20.w,
                          20.w + MediaQuery.of(context).viewInsets.bottom),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildProviderCard(provider),
                          SizedBox(height: 20.h),
                          _buildModeTabs(),
                          if (_lookupError != null) ...[
                            SizedBox(height: 14.h),
                            _buildLookupErrorCard(),
                          ],
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

  /// Auto / Manual. Two tabs rather than a buried "having trouble?" link:
  /// the choice is part of the task, and a customer whose meter never looks
  /// up should not have to fail first to discover the other route exists.
  Widget _buildModeTabs() {
    Widget tab(MeterEntryMode mode, String label, String subtitle) {
      final selected = _mode == mode;
      return Expanded(
        child: GestureDetector(
          key: Key('meter_mode_${mode.name}'),
          onTap: _isValidating
              ? null
              : () => setState(() {
                    _mode = mode;
                    // A failure from the other mode is not a statement about
                    // this one.
                    _lookupError = null;
                  }),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
            decoration: BoxDecoration(
              color: selected
                  ? const Color(0xFF4E03D0).withValues(alpha: 0.22)
                  : Colors.white.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: selected
                    ? const Color(0xFF8B7CF6)
                    : Colors.white.withValues(alpha: 0.10),
              ),
            ),
            child: Column(
              children: [
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 13.5.sp,
                    fontWeight: FontWeight.w600,
                    color: selected ? Colors.white : Colors.white70,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 10.5.sp,
                    color: Colors.white.withValues(alpha: 0.55),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Row(
      children: [
        tab(MeterEntryMode.auto, 'Auto', 'We confirm the name'),
        SizedBox(width: 10.w),
        tab(MeterEntryMode.manual, 'Manual', 'Enter it yourself'),
      ],
    );
  }

  /// The lookup failed. Say what happened, and put the only useful next step
  /// in reach — not in a snackbar that is already gone.
  Widget _buildLookupErrorCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2A1520),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFDC2626).withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.error_outline,
                  size: 17.sp, color: const Color(0xFFF87171)),
              SizedBox(width: 9.w),
              Expanded(
                child: Text(
                  _lookupError ?? '',
                  key: const Key('meter_lookup_error'),
                  style: GoogleFonts.inter(
                    fontSize: 12.5.sp,
                    color: Colors.white.withValues(alpha: 0.9),
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Text(
            'Some meters are not in the disco\'s directory even though they '
            'pay normally. You can enter the details yourself instead — we '
            'will not be able to confirm the account name.',
            style: GoogleFonts.inter(
              fontSize: 11.5.sp,
              color: Colors.white.withValues(alpha: 0.6),
              height: 1.4,
            ),
          ),
          SizedBox(height: 10.h),
          GestureDetector(
            key: const Key('meter_switch_to_manual'),
            onTap: () => setState(() {
              _mode = MeterEntryMode.manual;
              _lookupError = null;
            }),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 9.h, horizontal: 14.w),
              decoration: BoxDecoration(
                color: const Color(0xFF4E03D0),
                borderRadius: BorderRadius.circular(9.r),
              ),
              child: Text(
                'Enter details manually',
                style: GoogleFonts.inter(
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
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
              color: Colors.white.withValues(alpha: 0.2),
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
                    color: Colors.white.withValues(alpha: 0.8),
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
              ? const Color(0xFF4E03D0).withValues(alpha: 0.2)
              : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF4E03D0)
                : Colors.white.withValues(alpha: 0.1),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected
                  ? const Color(0xFF4E03D0)
                  : Colors.white.withValues(alpha: 0.6),
              size: 32.sp,
            ),
            SizedBox(height: 12.h),
            Text(
              label,
              style: GoogleFonts.inter(
                color: isSelected
                    ? Colors.white
                    : Colors.white.withValues(alpha: 0.6),
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
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(kMeterNumberMaxLen),
            ],
            onChanged: (_) => setState(() {}),
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              hintText:
                  '$kMeterNumberMinLen–$kMeterNumberMaxLen digit meter number',
              hintStyle: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.4),
                fontSize: 18.sp,
              ),
              border: InputBorder.none,
              icon: Icon(
                Icons.numbers,
                color: Colors.white.withValues(alpha: 0.4),
                size: 24.sp,
              ),
            ),
          ),
        ),
        // Live inline error when the user is still short of the min len.
        if (_meterNumberController.text.trim().isNotEmpty &&
            validateMeterNumber(_meterNumberController.text) != null) ...[
          SizedBox(height: 8.h),
          Text(
            validateMeterNumber(_meterNumberController.text)!,
            style: GoogleFonts.inter(
              color: const Color(0xFFEF4444),
              fontSize: 12.sp,
            ),
          ),
        ],
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
          color: _isValidating ? Colors.white.withValues(alpha: 0.1) : null,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: _isValidating
            ? Center(
                child: LazerVaultLoader.small(),
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
