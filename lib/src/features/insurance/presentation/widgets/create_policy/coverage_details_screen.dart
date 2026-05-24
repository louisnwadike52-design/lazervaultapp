import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import '../../cubit/create_policy_cubit.dart';
import 'monetary_form_field.dart';

/// Screen 3: Coverage Details
///
/// Premium amount, coverage amount, dates
class CoverageDetailsScreen extends StatefulWidget {
  const CoverageDetailsScreen({super.key});

  @override
  State<CoverageDetailsScreen> createState() => _CoverageDetailsScreenState();
}

class _CoverageDetailsScreenState extends State<CoverageDetailsScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Seed the MonetaryFormField with whatever the cubit already has
  // (e.g. the user navigated back to this screen). The widget itself
  // owns its TextEditingController; this screen just stores the
  // initial seed.
  late String _initialPremiumRaw;
  late String _initialCoverageRaw;

  @override
  void initState() {
    super.initState();

    final cubit = context.read<CreatePolicyCubit>();
    _initialPremiumRaw =
        cubit.premiumAmount != null ? cubit.premiumAmount!.toStringAsFixed(2) : '';
    _initialCoverageRaw =
        cubit.coverageAmount != null ? cubit.coverageAmount!.toStringAsFixed(2) : '';

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOutBack,
    ));

    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              SizedBox(height: 32.h),
              _buildPremiumField(),
              SizedBox(height: 20.h),
              _buildCoverageField(),
              SizedBox(height: 32.h),
              _buildDatesSection(),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Coverage Details',
          style: GoogleFonts.inter(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Set premium amount, coverage, and policy dates',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: Colors.grey[400],
          ),
        ),
      ],
    );
  }

  Widget _buildPremiumField() {
    final cubit = context.read<CreatePolicyCubit>();
    final currencyCode = cubit.activeCurrency;
    final symbol = CurrencySymbols.getSymbol(currencyCode);
    return MonetaryFormField(
      currencyCode: currencyCode,
      currencySymbol: symbol,
      initialRawValue: _initialPremiumRaw,
      label: 'Premium Amount',
      required: true,
      helperText: "The monthly or annual premium you'll pay",
      onChanged: (raw) {
        // raw is the cleaned numeric string ("1000000.50"). Empty means
        // the user cleared the field — push null so the cubit's
        // validator can flag it as missing.
        final amount = raw.isEmpty ? null : double.tryParse(raw);
        cubit.updatePremiumAmount(amount);
      },
    );
  }

  Widget _buildCoverageField() {
    final cubit = context.read<CreatePolicyCubit>();
    final currencyCode = cubit.activeCurrency;
    final symbol = CurrencySymbols.getSymbol(currencyCode);
    return MonetaryFormField(
      currencyCode: currencyCode,
      currencySymbol: symbol,
      initialRawValue: _initialCoverageRaw,
      label: 'Coverage Amount',
      required: true,
      helperText: 'Total coverage amount (must be greater than premium)',
      onChanged: (raw) {
        final amount = raw.isEmpty ? null : double.tryParse(raw);
        cubit.updateCoverageAmount(amount);
      },
    );
  }

  Widget _buildDatesSection() {
    return BlocBuilder<CreatePolicyCubit, dynamic>(
      builder: (context, state) {
        final cubit = context.read<CreatePolicyCubit>();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Policy Dates',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16.h),
            _buildDateField(
              label: 'Start Date',
              date: cubit.startDate,
              onTap: () => _selectDate(
                context,
                cubit.startDate,
                (date) => cubit.updateStartDate(date),
              ),
              required: true,
            ),
            SizedBox(height: 16.h),
            _buildDateField(
              label: 'End Date',
              date: cubit.endDate,
              onTap: () => _selectDate(
                context,
                cubit.endDate,
                (date) => cubit.updateEndDate(date),
              ),
              required: true,
              helperText: 'Policy must be at least 30 days long',
            ),
            SizedBox(height: 16.h),
            _buildDateField(
              label: 'Next Payment Date',
              date: cubit.nextPaymentDate,
              onTap: () => _selectDate(
                context,
                cubit.nextPaymentDate,
                (date) => cubit.updateNextPaymentDate(date),
              ),
              required: true,
              helperText: 'When your next premium is due',
            ),
          ],
        );
      },
    );
  }

  Widget _buildDateField({
    required String label,
    required DateTime date,
    required VoidCallback onTap,
    bool required = false,
    String? helperText,
  }) {
    final dateStr = DateFormat('MMM dd, yyyy').format(date);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            if (required)
              Text(
                ' *',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                ),
              ),
          ],
        ),
        SizedBox(height: 12.h),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.1),
                width: 1.5,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 20.sp,
                  color: Colors.white.withValues(alpha: 0.6),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    dateStr,
                    style: GoogleFonts.inter(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  size: 24.sp,
                  color: Colors.white.withValues(alpha: 0.6),
                ),
              ],
            ),
          ),
        ),
        if (helperText != null)
          Padding(
            padding: EdgeInsets.only(top: 8.h, left: 4.w),
            child: Text(
              helperText,
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey[500],
              ),
            ),
          ),
      ],
    );
  }

  Future<void> _selectDate(
    BuildContext context,
    DateTime initialDate,
    Function(DateTime) onDateSelected,
  ) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF6366F1),
              onPrimary: Colors.white,
              surface: Color(0xFF1A1A1A),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != initialDate) {
      onDateSelected(picked);
    }
  }
}
