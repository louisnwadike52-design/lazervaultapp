import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LazerVaultCardScreen extends StatefulWidget {
  const LazerVaultCardScreen({super.key});

  @override
  State<LazerVaultCardScreen> createState() => _LazerVaultCardScreenState();
}

class _LazerVaultCardScreenState extends State<LazerVaultCardScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _cardAnimationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _cardRotationAnimation;
  
  final bool _hasCard = false;
  int _selectedTab = 0;
  final PageController _pageController = PageController();
  
  final List<String> _tabs = ['Apply', 'Benefits', 'Support'];

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _cardAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    
    _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    
    _cardRotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _cardAnimationController, curve: Curves.elasticOut),
    );
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _cardAnimationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E27),
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
              _buildTabBar(),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) => setState(() => _selectedTab = index),
                  children: [
                    _buildApplyTab(),
                    _buildBenefitsTab(),
                    _buildSupportTab(),
                  ],
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
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1E2746),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              'LazerVault Card',
              style: GoogleFonts.inter(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          if (_hasCard)
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: const Color(0xFF1E2746),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.settings,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2746),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: _tabs.asMap().entries.map((entry) {
          final index = entry.key;
          final tab = entry.value;
          final isSelected = _selectedTab == index;
          
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() => _selectedTab = index);
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF6C5CE7) : Colors.transparent,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Center(
                  child: Text(
                    tab,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildApplyTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: AnimatedBuilder(
        animation: _slideAnimation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _slideAnimation.value),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                children: [
                  _buildHeroCard(),
                  SizedBox(height: 32.h),
                  _buildApplicationForm(),
                  SizedBox(height: 24.h),
                  _buildEligibilityRequirements(),
                  SizedBox(height: 32.h),
                  _buildApplyButton(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeroCard() {
    return SizedBox(
      height: 220.h,
      child: AnimatedBuilder(
        animation: _cardRotationAnimation,
        builder: (context, child) {
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(_cardRotationAnimation.value * 0.1),
            child: Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF6C5CE7),
                    const Color(0xFF1A237E),
                    const Color(0xFF000000),
                  ],
                ),
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6C5CE7).withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'LazerVault',
                        style: GoogleFonts.inter(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(
                          Icons.contactless,
                          color: Colors.white,
                          size: 24.sp,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    '•••• •••• •••• 1234',
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CARDHOLDER',
                            style: GoogleFonts.inter(
                              fontSize: 10.sp,
                              color: Colors.white.withOpacity(0.8),
                              letterSpacing: 1,
                            ),
                          ),
                          Text(
                            'JOHN DOE',
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'EXPIRES',
                            style: GoogleFonts.inter(
                              fontSize: 10.sp,
                              color: Colors.white.withOpacity(0.8),
                              letterSpacing: 1,
                            ),
                          ),
                          Text(
                            '12/28',
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildApplicationForm() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2746),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Start Your Application',
            style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Join millions of users who spend their crypto anywhere, anytime with zero fees.',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Colors.white.withOpacity(0.8),
              height: 1.5,
            ),
          ),
          SizedBox(height: 24.h),
          _buildFeatureItem(
            Icons.flash_on,
            'Instant Conversions',
            'Convert crypto to GBP instantly at the point of sale',
          ),
          SizedBox(height: 16.h),
          _buildFeatureItem(
            Icons.security,
            'Bank-Level Security',
            'Advanced encryption and fraud protection',
          ),
          SizedBox(height: 16.h),
          _buildFeatureItem(
            Icons.public,
            'Global Acceptance',
            'Use anywhere Visa is accepted worldwide',
          ),
          SizedBox(height: 16.h),
          _buildFeatureItem(
            Icons.money_off,
            'Zero Fees',
            'No transaction fees, no monthly fees, no hidden costs',
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String title, String description) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: const Color(0xFF6C5CE7).withOpacity(0.2),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF6C5CE7),
            size: 24.sp,
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Text(
                description,
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEligibilityRequirements() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2746),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.blue,
                size: 24.sp,
              ),
              SizedBox(width: 12.w),
              Text(
                'Eligibility Requirements',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildRequirement('18+ years old'),
          _buildRequirement('UK resident'),
          _buildRequirement('Active LazerVault account'),
          _buildRequirement('Verified identity'),
          _buildRequirement('Minimum £100 crypto balance'),
        ],
      ),
    );
  }

  Widget _buildRequirement(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          Icon(
            Icons.check,
            color: Colors.green,
            size: 16.sp,
          ),
          SizedBox(width: 8.w),
          Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApplyButton() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _startApplication,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6C5CE7),
              padding: EdgeInsets.symmetric(vertical: 18.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              elevation: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Apply for LazerVault Card',
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 20.sp,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          'Processing time: 5-7 business days',
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            color: Colors.white.withOpacity(0.6),
          ),
        ),
      ],
    );
  }

  Widget _buildBenefitsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          _buildBenefitCard(
            'Zero Transaction Fees',
            'Spend your crypto anywhere with no transaction fees, no monthly fees, and no hidden costs.',
            Icons.money_off,
            Colors.green,
          ),
          SizedBox(height: 16.h),
          _buildBenefitCard(
            'Instant Crypto Conversion',
            'Your crypto is instantly converted to GBP at the point of sale with real-time exchange rates.',
            Icons.swap_horiz,
            const Color(0xFF6C5CE7),
          ),
          SizedBox(height: 16.h),
          _buildBenefitCard(
            'Global Acceptance',
            'Use your LazerVault Card anywhere Visa is accepted worldwide - online and in stores.',
            Icons.public,
            Colors.blue,
          ),
          SizedBox(height: 16.h),
          _buildBenefitCard(
            'Real-Time Notifications',
            'Get instant notifications for every transaction with detailed spending insights.',
            Icons.notifications_active,
            Colors.orange,
          ),
          SizedBox(height: 16.h),
          _buildBenefitCard(
            'Advanced Security',
            'Bank-level security with 3D Secure, fraud protection, and instant card controls.',
            Icons.security,
            Colors.red,
          ),
          SizedBox(height: 16.h),
          _buildBenefitCard(
            'Cashback Rewards',
            'Earn up to 8% cashback in crypto on all purchases with our rewards program.',
            Icons.card_giftcard,
            Colors.purple,
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitCard(String title, String description, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2746),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              icon,
              color: color,
              size: 32.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  description,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: Colors.white.withOpacity(0.8),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupportTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          _buildSupportSection(
            'Frequently Asked Questions',
            Icons.help_outline,
            [
              'How do I apply for a LazerVault Card?',
              'What are the fees and charges?',
              'How does crypto conversion work?',
              'Is my card accepted worldwide?',
              'How do I freeze/unfreeze my card?',
            ],
          ),
          SizedBox(height: 24.h),
          _buildSupportSection(
            'Contact Support',
            Icons.support_agent,
            [
              'Live Chat: Available 24/7',
              'Email: card@lazervault.com',
              'Phone: +44 20 7946 0958',
              'Response time: Usually within 1 hour',
            ],
          ),
          SizedBox(height: 24.h),
          _buildSupportSection(
            'Card Management',
            Icons.credit_card,
            [
              'View PIN and card details',
              'Set spending limits',
              'Freeze/unfreeze instantly',
              'Transaction history and receipts',
              'Replace lost or stolen card',
            ],
          ),
          SizedBox(height: 32.h),
          _buildEmergencyContact(),
        ],
      ),
    );
  }

  Widget _buildSupportSection(String title, IconData icon, List<String> items) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2746),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: const Color(0xFF6C5CE7),
                size: 24.sp,
              ),
              SizedBox(width: 12.w),
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ...items.map((item) => _buildSupportItem(item)),
        ],
      ),
    );
  }

  Widget _buildSupportItem(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Icon(
            Icons.chevron_right,
            color: Colors.white.withOpacity(0.6),
            size: 16.sp,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyContact() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.emergency,
                color: Colors.red,
                size: 24.sp,
              ),
              SizedBox(width: 12.w),
              Text(
                'Emergency Support',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            'If your card is lost or stolen, immediately freeze it in the app or call our emergency hotline:',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            '+44 800 123 4567',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _freezeCard,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                'Freeze Card Immediately',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
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

  void _startApplication() {
    _cardAnimationController.forward();
    
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1E2746),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.credit_card,
                color: const Color(0xFF6C5CE7),
                size: 48.sp,
              ),
              SizedBox(height: 16.h),
              Text(
                'Application Started',
                style: GoogleFonts.inter(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'We\'ll review your application and get back to you within 5-7 business days.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C5CE7),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    'Continue',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
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

  void _freezeCard() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1E2746),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.ac_unit,
                color: Colors.blue,
                size: 48.sp,
              ),
              SizedBox(height: 16.h),
              Text(
                'Card Frozen',
                style: GoogleFonts.inter(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Your LazerVault Card has been frozen. All transactions are now blocked.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    'OK',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
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
} 