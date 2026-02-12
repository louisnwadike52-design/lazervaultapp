import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class _FaqItem {
  final String question;
  final String answer;
  final String category;

  const _FaqItem({
    required this.question,
    required this.answer,
    required this.category,
  });
}

class InsuranceFaqScreen extends StatefulWidget {
  const InsuranceFaqScreen({super.key});

  @override
  State<InsuranceFaqScreen> createState() => _InsuranceFaqScreenState();
}

class _InsuranceFaqScreenState extends State<InsuranceFaqScreen> {
  String _searchQuery = '';
  String _selectedCategory = 'All';
  int? _expandedFaqIndex;
  final TextEditingController _searchController = TextEditingController();

  static const _categories = ['All', 'Policies', 'Claims', 'Payments', 'Coverage'];

  static const _faqItems = <_FaqItem>[
    // Policies
    _FaqItem(
      question: 'What types of insurance are available?',
      answer:
          'We offer health, auto, travel, gadget, home, life, marine, and personal accident insurance through our partner network.',
      category: 'Policies',
    ),
    _FaqItem(
      question: 'How do I purchase an insurance policy?',
      answer:
          'Browse available products, get a quote, review the terms, and confirm payment from your LazerVault account.',
      category: 'Policies',
    ),
    _FaqItem(
      question: 'Can I cancel my insurance policy?',
      answer:
          'Yes, you can cancel your policy. Cancellation terms vary by provider. Contact the provider through the app for details.',
      category: 'Policies',
    ),
    _FaqItem(
      question: 'How long does it take to activate my policy?',
      answer:
          'Most policies are activated instantly after successful payment. Some may take up to 24 hours.',
      category: 'Policies',
    ),
    // Claims
    _FaqItem(
      question: 'How do I file an insurance claim?',
      answer:
          "Go to your policy details, tap 'File Claim', fill in the incident details, attach supporting documents, and submit.",
      category: 'Claims',
    ),
    _FaqItem(
      question: 'How long does claim processing take?',
      answer:
          'Claims are typically reviewed within 5-10 business days. Complex claims may take longer.',
      category: 'Claims',
    ),
    _FaqItem(
      question: 'What documents do I need for a claim?',
      answer:
          "You'll typically need incident photos, police reports (if applicable), medical reports, and any other relevant documentation.",
      category: 'Claims',
    ),
    _FaqItem(
      question: 'Can I track my claim status?',
      answer:
          'Yes, you can track your claim in real-time from your policy details page.',
      category: 'Claims',
    ),
    // Payments
    _FaqItem(
      question: 'What payment methods are accepted?',
      answer:
          'You can pay premiums directly from your LazerVault wallet balance.',
      category: 'Payments',
    ),
    _FaqItem(
      question: 'Is my payment information secure?',
      answer:
          'Yes, all payments are processed through our secure payment infrastructure with bank-level encryption.',
      category: 'Payments',
    ),
    _FaqItem(
      question: 'Can I set up automatic premium payments?',
      answer:
          "Automatic payments are coming soon. Currently, you'll receive reminders when premiums are due.",
      category: 'Payments',
    ),
    // Coverage
    _FaqItem(
      question: 'What does my insurance cover?',
      answer:
          'Coverage varies by product. Check your policy details for a complete list of covered events and amounts.',
      category: 'Coverage',
    ),
    _FaqItem(
      question: 'Are pre-existing conditions covered?',
      answer:
          'Coverage for pre-existing conditions depends on the specific policy. Review the terms and conditions carefully.',
      category: 'Coverage',
    ),
    _FaqItem(
      question: 'Can I increase my coverage amount?',
      answer:
          'Contact your insurance provider through the app to discuss coverage modifications.',
      category: 'Coverage',
    ),
    _FaqItem(
      question: 'What is not covered by my insurance?',
      answer:
          'Exclusions vary by policy. Common exclusions include intentional damage, war, and nuclear events. Check your policy terms.',
      category: 'Coverage',
    ),
  ];

  List<_FaqItem> get _filteredFaqs {
    return _faqItems.where((faq) {
      final matchesCategory =
          _selectedCategory == 'All' || faq.category == _selectedCategory;
      final query = _searchQuery.toLowerCase();
      final matchesSearch = query.isEmpty ||
          faq.question.toLowerCase().contains(query) ||
          faq.answer.toLowerCase().contains(query);
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: 16.h),
            _buildSearchBar(),
            SizedBox(height: 16.h),
            _buildCategoryChips(),
            SizedBox(height: 16.h),
            Expanded(child: _buildFaqList()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
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
                'FAQ',
                style: GoogleFonts.inter(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                'Frequently asked questions',
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
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

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
            _expandedFaqIndex = null;
          });
        },
        style: GoogleFonts.inter(
          fontSize: 14.sp,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          hintText: 'Search questions...',
          hintStyle: GoogleFonts.inter(
            fontSize: 14.sp,
            color: const Color(0xFF9CA3AF),
          ),
          prefixIcon: Icon(
            Icons.search,
            color: const Color(0xFF9CA3AF),
            size: 20.sp,
          ),
          filled: true,
          fillColor: const Color(0xFF1F1F1F),
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
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
            borderSide: const BorderSide(color: Color(0xFF6366F1)),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChips() {
    return SizedBox(
      height: 40.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemCount: _categories.length,
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = _selectedCategory == category;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategory = category;
                _expandedFaqIndex = null;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF6366F1)
                    : const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(20.r),
                border: isSelected
                    ? null
                    : Border.all(color: const Color(0xFF2D2D2D)),
              ),
              child: Center(
                child: Text(
                  category,
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected ? Colors.white : const Color(0xFF9CA3AF),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFaqList() {
    final faqs = _filteredFaqs;

    if (faqs.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off_rounded,
              color: const Color(0xFF9CA3AF),
              size: 48.sp,
            ),
            SizedBox(height: 12.h),
            Text(
              'No matching questions found',
              style: GoogleFonts.inter(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF9CA3AF),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 20.w).copyWith(bottom: 24.h),
      itemCount: faqs.length,
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        final faq = faqs[index];
        final globalIndex = _faqItems.indexOf(faq);
        final isExpanded = _expandedFaqIndex == globalIndex;

        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFF2D2D2D)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _expandedFaqIndex = isExpanded ? null : globalIndex;
                  });
                },
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          faq.question,
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      AnimatedRotation(
                        turns: isExpanded ? 0.5 : 0.0,
                        duration: const Duration(milliseconds: 200),
                        child: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: const Color(0xFF9CA3AF),
                          size: 22.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: Padding(
                  padding: EdgeInsets.only(
                    left: 16.w,
                    right: 16.w,
                    bottom: 16.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(
                        color: const Color(0xFF2D2D2D),
                        height: 1.h,
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        faq.answer,
                        style: GoogleFonts.inter(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF9CA3AF),
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6366F1).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          faq.category,
                          style: GoogleFonts.inter(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF8B5CF6),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                crossFadeState: isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 200),
              ),
            ],
          ),
        );
      },
    );
  }
}
