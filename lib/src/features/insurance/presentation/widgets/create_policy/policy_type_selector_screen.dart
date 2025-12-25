import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../domain/entities/insurance_entity.dart';
import '../../cubit/create_policy_cubit.dart';

/// Screen 1: Policy Type & Provider Selection
///
/// Allows user to select insurance type and provider
class PolicyTypeSelectorScreen extends StatefulWidget {
  const PolicyTypeSelectorScreen({super.key});

  @override
  State<PolicyTypeSelectorScreen> createState() =>
      _PolicyTypeSelectorScreenState();
}

class _PolicyTypeSelectorScreenState extends State<PolicyTypeSelectorScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  final List<String> _availableProviders = [
    'SafeGuard Insurance',
    'Allstate Insurance',
    'State Farm Insurance',
    'Progressive Insurance',
    'GEICO Insurance',
    'Nationwide Insurance',
    'Liberty Mutual',
    'Farmers Insurance',
    'Travelers Insurance',
    'American Family Insurance',
    'USAA Insurance',
    'Aetna Health Insurance',
    'Blue Cross Blue Shield',
    'Cigna Health Insurance',
    'UnitedHealth Group',
    'Humana Health Insurance',
  ];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

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
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: 32.h),
            _buildInsuranceTypeSection(),
            SizedBox(height: 32.h),
            _buildProviderSection(),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Insurance Type',
          style: GoogleFonts.inter(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Choose the type of insurance policy you want to create',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: Colors.grey[400],
          ),
        ),
      ],
    );
  }

  Widget _buildInsuranceTypeSection() {
    return BlocBuilder<CreatePolicyCubit, dynamic>(
      builder: (context, state) {
        final cubit = context.read<CreatePolicyCubit>();
        final currentType = cubit.insuranceType;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Type',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16.h),
            Wrap(
              spacing: 12.w,
              runSpacing: 12.h,
              children: [
                _buildTypeCard(
                  InsuranceType.health,
                  'Health',
                  Icons.local_hospital,
                  currentType,
                ),
                _buildTypeCard(
                  InsuranceType.auto,
                  'Auto',
                  Icons.directions_car,
                  currentType,
                ),
                _buildTypeCard(
                  InsuranceType.home,
                  'Home',
                  Icons.home,
                  currentType,
                ),
                _buildTypeCard(
                  InsuranceType.life,
                  'Life',
                  Icons.favorite,
                  currentType,
                ),
                _buildTypeCard(
                  InsuranceType.travel,
                  'Travel',
                  Icons.flight,
                  currentType,
                ),
                _buildTypeCard(
                  InsuranceType.business,
                  'Business',
                  Icons.business_center,
                  currentType,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildTypeCard(
    InsuranceType type,
    String label,
    IconData icon,
    InsuranceType currentType,
  ) {
    final isSelected = type == currentType;

    return GestureDetector(
      onTap: () {
        context.read<CreatePolicyCubit>().updateInsuranceType(type);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 105.w,
        height: 105.w,
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isSelected ? null : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected
                ? Colors.transparent
                : Colors.white.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 36.sp,
              color: Colors.white,
            ),
            SizedBox(height: 8.h),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProviderSection() {
    return BlocBuilder<CreatePolicyCubit, dynamic>(
      builder: (context, state) {
        final cubit = context.read<CreatePolicyCubit>();
        final provider = cubit.provider;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Insurance Provider',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16.h),
            GestureDetector(
              onTap: () => _showProviderDialog(context),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: provider.isEmpty
                        ? Colors.white.withValues(alpha: 0.1)
                        : const Color(0xFF6366F1),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.business,
                      size: 20.sp,
                      color: Colors.white.withValues(alpha: 0.6),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        provider.isEmpty ? 'Select provider' : provider,
                        style: GoogleFonts.inter(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: provider.isEmpty
                              ? Colors.grey[400]
                              : Colors.white,
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
            if (provider.isEmpty)
              Padding(
                padding: EdgeInsets.only(top: 8.h, left: 4.w),
                child: Text(
                  'Required field',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[500],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  void _showProviderDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Select Insurance Provider',
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: _availableProviders.length,
            separatorBuilder: (context, index) => Divider(
              color: Colors.white.withValues(alpha: 0.1),
              height: 1,
            ),
            itemBuilder: (context, index) {
              final provider = _availableProviders[index];
              final cubit = context.read<CreatePolicyCubit>();
              final isSelected = cubit.provider == provider;

              return ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 4.h,
                ),
                title: Text(
                  provider,
                  style: GoogleFonts.inter(
                    fontSize: 15.sp,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                trailing: isSelected
                    ? Icon(
                        Icons.check_circle,
                        color: const Color(0xFF6366F1),
                        size: 20.sp,
                      )
                    : null,
                onTap: () {
                  cubit.updateProvider(provider);
                  Navigator.of(dialogContext).pop();
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey[400],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
