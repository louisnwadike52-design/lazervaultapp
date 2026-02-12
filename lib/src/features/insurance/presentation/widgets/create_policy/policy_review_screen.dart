import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../cubit/create_policy_cubit.dart';
import '../../../domain/entities/insurance_entity.dart';

/// Screen 5: Policy Review
///
/// Summary of all entered information and optional fields
class PolicyReviewScreen extends StatefulWidget {
  const PolicyReviewScreen({super.key});

  @override
  State<PolicyReviewScreen> createState() => _PolicyReviewScreenState();
}

class _PolicyReviewScreenState extends State<PolicyReviewScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final cubit = context.read<CreatePolicyCubit>();
    final description = cubit.optionalFields['description'] as String?;
    if (description != null) {
      _descriptionController.text = description;
    }

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
    _descriptionController.dispose();
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
          child: BlocBuilder<CreatePolicyCubit, dynamic>(
            builder: (context, state) {
              final cubit = context.read<CreatePolicyCubit>();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  SizedBox(height: 24.h),
                  _buildSummaryCard(
                    'Policy Type & Provider',
                    [
                      _buildInfoRow('Type', _getTypeDisplayName(cubit.insuranceType)),
                      _buildInfoRow('Provider', cubit.provider),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  _buildSummaryCard(
                    'Policy Holder',
                    [
                      _buildInfoRow('Name', cubit.policyHolderName),
                      _buildInfoRow('Email', cubit.policyHolderEmail),
                      _buildInfoRow('Phone', cubit.policyHolderPhone),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  _buildSummaryCard(
                    'Coverage Details',
                    [
                      _buildInfoRow(
                        'Premium',
                        '\$${cubit.premiumAmount?.toStringAsFixed(2) ?? '0.00'}',
                      ),
                      _buildInfoRow(
                        'Coverage',
                        '\$${cubit.coverageAmount?.toStringAsFixed(2) ?? '0.00'}',
                      ),
                      _buildInfoRow(
                        'Start Date',
                        DateFormat('MMM dd, yyyy').format(cubit.startDate),
                      ),
                      _buildInfoRow(
                        'End Date',
                        DateFormat('MMM dd, yyyy').format(cubit.endDate),
                      ),
                      _buildInfoRow(
                        'Next Payment',
                        DateFormat('MMM dd, yyyy').format(cubit.nextPaymentDate),
                      ),
                    ],
                  ),
                  if (cubit.beneficiaries.isNotEmpty) ...[
                    SizedBox(height: 16.h),
                    _buildSummaryCard(
                      'Beneficiaries',
                      cubit.beneficiaries
                          .map((b) => _buildInfoRow('', b))
                          .toList(),
                    ),
                  ],
                  if (cubit.features.isNotEmpty) ...[
                    SizedBox(height: 16.h),
                    _buildFeaturesCard(cubit.features),
                  ],
                  SizedBox(height: 24.h),
                  _buildOptionalFieldsSection(),
                  SizedBox(height: 24.h),
                ],
              );
            },
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
          'Review & Confirm',
          style: GoogleFonts.inter(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Review your policy details before proceeding to payment',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: Colors.grey[400],
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(String title, List<Widget> rows) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 12.h),
          ...rows,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: label.isEmpty ? 4.h : 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label.isNotEmpty) ...[
            SizedBox(
              width: 110.w,
              child: Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[400],
                ),
              ),
            ),
            SizedBox(width: 12.w),
          ],
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesCard(List<String> features) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Coverage Features',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: features.map((feature) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF6366F1).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  feature,
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionalFieldsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.note_add_outlined,
              size: 20.sp,
              color: Colors.white.withValues(alpha: 0.6),
            ),
            SizedBox(width: 8.w),
            Text(
              'Additional Details (Optional)',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        TextField(
          controller: _descriptionController,
          maxLines: 4,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          onChanged: (value) {
            context.read<CreatePolicyCubit>().updateOptionalField(
                  'description',
                  value,
                );
          },
          decoration: InputDecoration(
            hintText: 'Add any additional notes or details about this policy...',
            hintStyle: GoogleFonts.inter(
              fontSize: 14.sp,
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
      ],
    );
  }

  String _getTypeDisplayName(InsuranceType type) {
    switch (type) {
      case InsuranceType.health:
        return 'Health Insurance';
      case InsuranceType.auto:
        return 'Auto Insurance';
      case InsuranceType.home:
        return 'Home Insurance';
      case InsuranceType.life:
        return 'Life Insurance';
      case InsuranceType.travel:
        return 'Travel Insurance';
      case InsuranceType.business:
        return 'Business Insurance';
      case InsuranceType.gadget:
        return 'Gadget Insurance';
    }
  }
}
