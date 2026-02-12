import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/types/app_routes.dart';

import '../../domain/entities/insurance_product_entity.dart';

class InsuranceGuideScreen extends StatefulWidget {
  const InsuranceGuideScreen({super.key});

  @override
  State<InsuranceGuideScreen> createState() => _InsuranceGuideScreenState();
}

class _InsuranceGuideScreenState extends State<InsuranceGuideScreen> {
  int? _expandedPolicyIndex;
  int? _expandedGlossaryIndex;

  static const _policyTerms = [
    {
      'title': 'Premium',
      'description':
          'The amount you pay regularly to maintain your coverage',
    },
    {
      'title': 'Deductible',
      'description':
          'The amount you pay out-of-pocket before coverage kicks in',
    },
    {
      'title': 'Coverage Limit',
      'description':
          'The maximum amount your insurer will pay for a covered claim',
    },
    {
      'title': 'Exclusions',
      'description':
          'Specific situations or conditions not covered by your policy',
    },
    {
      'title': 'Claim',
      'description':
          'A formal request to your insurer for payment after a covered event',
    },
  ];

  static const _tips = [
    'Assess your risks and coverage needs',
    'Compare quotes from multiple providers',
    'Read the fine print and exclusions',
    'Consider the deductible vs premium trade-off',
    'Review and update your coverage annually',
  ];

  static const _glossaryTerms = [
    {
      'term': 'Beneficiary',
      'definition':
          'A person designated to receive benefits from an insurance policy',
    },
    {
      'term': 'Underwriting',
      'definition':
          'The process insurers use to evaluate risk and determine premiums',
    },
    {
      'term': 'Rider',
      'definition':
          'An add-on to a base policy that provides additional coverage',
    },
    {
      'term': 'Actuary',
      'definition':
          'A professional who analyzes financial risk using mathematics and statistics',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.h),
                    _buildHeader(),
                    SizedBox(height: 24.h),
                    _buildHeroCard(),
                    SizedBox(height: 32.h),
                    _buildTypesOfInsurance(),
                    SizedBox(height: 32.h),
                    _buildUnderstandingYourPolicy(),
                    SizedBox(height: 32.h),
                    _buildTipsSection(),
                    SizedBox(height: 32.h),
                    _buildGlossarySection(),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
            _buildBottomCta(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Insurance Guide',
                style: GoogleFonts.inter(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                'Learn about insurance',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeroCard() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF6366F1),
              Color(0xFF8B5CF6),
            ],
          ),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 56.w,
              height: 56.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Icon(
                Icons.shield,
                color: Colors.white,
                size: 28.sp,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Insurance Learning Hub',
              style: GoogleFonts.inter(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Everything you need to know about protecting what matters',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.white.withValues(alpha: 0.85),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypesOfInsurance() {
    final categories = InsuranceProductCategory.values;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Types of Insurance',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 12.h,
              childAspectRatio: 1.6,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(
                    color: const Color(0xFF2D2D2D),
                  ),
                ),
                padding: EdgeInsets.all(14.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      category.icon,
                      color: const Color(0xFF6366F1),
                      size: 28.sp,
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      category.displayName,
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildUnderstandingYourPolicy() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Understanding Your Policy',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          ...List.generate(_policyTerms.length, (index) {
            final term = _policyTerms[index];
            final isExpanded = _expandedPolicyIndex == index;
            return Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _expandedPolicyIndex = isExpanded ? null : index;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(
                      color: isExpanded
                          ? const Color(0xFF6366F1).withValues(alpha: 0.5)
                          : const Color(0xFF2D2D2D),
                    ),
                  ),
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              term['title']!,
                              style: GoogleFonts.inter(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          AnimatedRotation(
                            turns: isExpanded ? 0.5 : 0.0,
                            duration: const Duration(milliseconds: 200),
                            child: Icon(
                              Icons.chevron_right,
                              color: const Color(0xFF9CA3AF),
                              size: 22.sp,
                            ),
                          ),
                        ],
                      ),
                      if (isExpanded) ...[
                        SizedBox(height: 10.h),
                        Text(
                          term['description']!,
                          style: GoogleFonts.inter(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF9CA3AF),
                            height: 1.5,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTipsSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tips for Choosing Insurance',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          ...List.generate(_tips.length, (index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(
                    color: const Color(0xFF2D2D2D),
                  ),
                ),
                padding: EdgeInsets.all(16.w),
                child: Row(
                  children: [
                    Container(
                      width: 32.w,
                      height: 32.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFF6366F1).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF6366F1),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 14.w),
                    Expanded(
                      child: Text(
                        _tips[index],
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildGlossarySection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Insurance Glossary',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          ...List.generate(_glossaryTerms.length, (index) {
            final term = _glossaryTerms[index];
            final isExpanded = _expandedGlossaryIndex == index;
            return Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _expandedGlossaryIndex = isExpanded ? null : index;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(
                      color: isExpanded
                          ? const Color(0xFF8B5CF6).withValues(alpha: 0.5)
                          : const Color(0xFF2D2D2D),
                    ),
                  ),
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              term['term']!,
                              style: GoogleFonts.inter(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          AnimatedRotation(
                            turns: isExpanded ? 0.5 : 0.0,
                            duration: const Duration(milliseconds: 200),
                            child: Icon(
                              Icons.chevron_right,
                              color: const Color(0xFF9CA3AF),
                              size: 22.sp,
                            ),
                          ),
                        ],
                      ),
                      if (isExpanded) ...[
                        SizedBox(height: 10.h),
                        Text(
                          term['definition']!,
                          style: GoogleFonts.inter(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF9CA3AF),
                            height: 1.5,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildBottomCta() {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 16.h),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        border: Border(
          top: BorderSide(
            color: const Color(0xFF2D2D2D),
          ),
        ),
      ),
      child: GestureDetector(
        onTap: () => Get.toNamed(AppRoutes.createInsurance),
        child: Container(
          width: double.infinity,
          height: 52.h,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFF6366F1),
                Color(0xFF8B5CF6),
              ],
            ),
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Center(
            child: Text(
              'Browse Insurance',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
