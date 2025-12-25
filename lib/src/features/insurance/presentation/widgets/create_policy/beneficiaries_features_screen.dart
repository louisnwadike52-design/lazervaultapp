import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../cubit/create_policy_cubit.dart';

/// Screen 4: Beneficiaries & Features
///
/// Add beneficiaries and select policy features (both optional)
class BeneficiariesFeaturesScreen extends StatefulWidget {
  const BeneficiariesFeaturesScreen({super.key});

  @override
  State<BeneficiariesFeaturesScreen> createState() =>
      _BeneficiariesFeaturesScreenState();
}

class _BeneficiariesFeaturesScreenState
    extends State<BeneficiariesFeaturesScreen> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final TextEditingController _beneficiaryController = TextEditingController();

  final List<String> _availableFeatures = [
    '24/7 Customer Support',
    'Online Claims Processing',
    'Mobile App Access',
    'Roadside Assistance',
    'Telemedicine Services',
    'Worldwide Coverage',
    'No Claim Bonus',
    'Cashless Hospitalization',
    'Ambulance Services',
    'Pre-existing Conditions',
    'Maternity Coverage',
    'Dental Coverage',
    'Vision Coverage',
    'Mental Health Coverage',
    'Prescription Drug Coverage',
    'Preventive Care',
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
    _beneficiaryController.dispose();
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
              _buildBeneficiariesSection(),
              SizedBox(height: 32.h),
              _buildFeaturesSection(),
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
          'Beneficiaries & Features',
          style: GoogleFonts.inter(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Add beneficiaries and select coverage features (optional)',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: Colors.grey[400],
          ),
        ),
      ],
    );
  }

  Widget _buildBeneficiariesSection() {
    return BlocBuilder<CreatePolicyCubit, dynamic>(
      builder: (context, state) {
        final cubit = context.read<CreatePolicyCubit>();
        final beneficiaries = cubit.beneficiaries;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Beneficiaries',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'People who will receive benefits from this policy',
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey[500],
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _beneficiaryController,
                    style: GoogleFonts.inter(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter beneficiary name',
                      hintStyle: GoogleFonts.inter(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[500],
                      ),
                      filled: true,
                      fillColor: Colors.white.withValues(alpha: 0.05),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(
                          color: Colors.white.withValues(alpha: 0.1),
                          width: 1.5,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(
                          color: Colors.white.withValues(alpha: 0.1),
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(
                          color: Color(0xFF6366F1),
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                GestureDetector(
                  onTap: () {
                    if (_beneficiaryController.text.isNotEmpty) {
                      cubit.addBeneficiary(_beneficiaryController.text);
                      _beneficiaryController.clear();
                    }
                  },
                  child: Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 24.sp,
                    ),
                  ),
                ),
              ],
            ),
            if (beneficiaries.isNotEmpty) ...[
              SizedBox(height: 16.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: beneficiaries.map((beneficiary) {
                  return _buildBeneficiaryChip(beneficiary);
                }).toList(),
              ),
            ] else ...[
              SizedBox(height: 12.h),
              Center(
                child: Text(
                  'No beneficiaries added yet',
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _buildBeneficiaryChip(String beneficiary) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFF6366F1).withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: const Color(0xFF6366F1).withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.person,
            size: 16.sp,
            color: const Color(0xFF6366F1),
          ),
          SizedBox(width: 6.w),
          Text(
            beneficiary,
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 6.w),
          GestureDetector(
            onTap: () {
              context.read<CreatePolicyCubit>().removeBeneficiary(beneficiary);
            },
            child: Icon(
              Icons.close,
              size: 16.sp,
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection() {
    return BlocBuilder<CreatePolicyCubit, dynamic>(
      builder: (context, state) {
        final cubit = context.read<CreatePolicyCubit>();
        final selectedFeatures = cubit.features;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Coverage Features',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Select features included in your policy',
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey[500],
              ),
            ),
            SizedBox(height: 16.h),
            Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: _availableFeatures.map((feature) {
                final isSelected = selectedFeatures.contains(feature);
                return _buildFeatureChip(feature, isSelected);
              }).toList(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFeatureChip(String feature, bool isSelected) {
    return GestureDetector(
      onTap: () {
        final cubit = context.read<CreatePolicyCubit>();
        if (isSelected) {
          cubit.removeFeature(feature);
        } else {
          cubit.addFeature(feature);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isSelected ? null : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isSelected
                ? Colors.transparent
                : Colors.white.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSelected)
              Padding(
                padding: EdgeInsets.only(right: 6.w),
                child: Icon(
                  Icons.check_circle,
                  size: 16.sp,
                  color: Colors.white,
                ),
              ),
            Text(
              feature,
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
