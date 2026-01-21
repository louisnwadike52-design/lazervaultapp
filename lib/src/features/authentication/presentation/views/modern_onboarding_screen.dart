import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ModernOnboardingScreen extends StatefulWidget {
  const ModernOnboardingScreen({super.key});

  @override
  State<ModernOnboardingScreen> createState() => _ModernOnboardingScreenState();
}

class _ModernOnboardingScreenState extends State<ModernOnboardingScreen> with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      title: 'Welcome to LazerVault',
      subtitle: 'Your All-in-One Financial Super App',
      description: 'Experience the future of banking with everything you need in one powerful platform.',
      icon: Icons.account_balance_wallet_rounded,
      imagePath: 'assets/images/onboarding/welcome_banking.png',
      features: [
        'Multi-currency wallet support',
        'Real-time transaction tracking',
        'Secure and encrypted data',
      ],
      useLightTheme: true,
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFFFFFFF), Color(0xFFF8FAFC), Color(0xFFF1F5F9)],
      ),
    ),
    OnboardingPage(
      title: 'Global Money Transfers',
      subtitle: 'Send & Receive Worldwide',
      description: 'Transfer money across borders with lightning speed and minimal fees.',
      icon: Icons.send_rounded,
      imagePath: 'assets/images/onboarding/global_transfers.png',
      features: [
        'Support for 50+ currencies',
        'Best exchange rates guaranteed',
        'Instant international transfers',
      ],
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF0EA5E9), Color(0xFF06B6D4), Color(0xFF0891B2)],
      ),
    ),
    OnboardingPage(
      title: 'Smart Investing',
      subtitle: 'Stocks, Crypto & Portfolios',
      description: 'Build wealth with intelligent investment tools and real-time market insights.',
      icon: Icons.trending_up_rounded,
      imagePath: 'assets/images/onboarding/smart_investing.png',
      features: [
        'Trade stocks & cryptocurrencies',
        'Portfolio analytics & insights',
        'Automated investment strategies',
      ],
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF10B981), Color(0xFF059669), Color(0xFF047857)],
      ),
    ),
    OnboardingPage(
      title: 'Effortless Payments',
      subtitle: 'Bills, Airtime & More',
      description: 'Pay all your bills, manage subscriptions, and handle daily expenses with ease.',
      icon: Icons.payment_rounded,
      imagePath: 'assets/images/onboarding/easy_payments.png',
      features: [
        'Electricity, water & utility bills',
        'Mobile airtime & data top-up',
        'Split bills with friends instantly',
      ],
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFF59E0B), Color(0xFFEF4444), Color(0xFFDC2626)],
      ),
    ),
    OnboardingPage(
      title: 'Advanced Security',
      subtitle: 'Voice Auth & AI Protection',
      description: 'Your security is our priority with cutting-edge authentication and fraud prevention.',
      icon: Icons.security_rounded,
      imagePath: 'assets/images/onboarding/advanced_security.png',
      features: [
        'Biometric & voice authentication',
        'AI-powered fraud detection',
        'End-to-end encryption',
      ],
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFEC4899), Color(0xFF8B5CF6), Color(0xFF6366F1)],
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeOutBack),
    );
    _fadeController.forward();
    _scaleController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _fadeController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
    _fadeController.reset();
    _scaleController.reset();
    _fadeController.forward();
    _scaleController.forward();
  }

  Future<void> _completeOnboarding() async {
    const storage = FlutterSecureStorage();
    await storage.write(key: 'has_seen_onboarding', value: 'true');
    Get.offAllNamed(AppRoutes.signUp);
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    } else {
      _completeOnboarding();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        decoration: BoxDecoration(
          gradient: _pages[_currentPage].gradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header with Logo and Skip button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Logo
                    Hero(
                      tag: 'app_logo',
                      child: Image.asset(
                        'assets/images/logos/lazervault-full-logo-no-background.png',
                        height: 36.h,
                      ),
                    ),
                    // Skip button
                    TextButton(
                      onPressed: _completeOnboarding,
                      style: TextButton.styleFrom(
                        foregroundColor: _pages[_currentPage].useLightTheme ? const Color(0xFF6366F1) : Colors.white,
                        backgroundColor: _pages[_currentPage].useLightTheme
                            ? const Color(0xFF6366F1).withOpacity(0.1)
                            : Colors.white.withOpacity(0.15),
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      ),
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Page content
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemCount: _pages.length,
                  itemBuilder: (context, index) {
                    return _buildPage(_pages[index]);
                  },
                ),
              ),

              // Bottom section with indicator and buttons
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                child: Column(
                  children: [
                    // Page indicator
                    SmoothPageIndicator(
                      controller: _pageController,
                      count: _pages.length,
                      effect: ExpandingDotsEffect(
                        activeDotColor: _pages[_currentPage].useLightTheme ? const Color(0xFF6366F1) : Colors.white,
                        dotColor: _pages[_currentPage].useLightTheme ? const Color(0xFF6366F1).withOpacity(0.3) : Colors.white.withOpacity(0.3),
                        dotHeight: 10.h,
                        dotWidth: 10.w,
                        expansionFactor: 4,
                        spacing: 8.w,
                      ),
                    ),
                    SizedBox(height: 28.h),

                    // Next/Get Started button
                    SizedBox(
                      width: double.infinity,
                      height: 60.h,
                      child: ElevatedButton(
                        onPressed: _nextPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _pages[_currentPage].useLightTheme ? const Color(0xFF6366F1) : Colors.white,
                          foregroundColor: _pages[_currentPage].useLightTheme ? Colors.white : _pages[_currentPage].gradient.colors.first,
                          elevation: 8,
                          shadowColor: Colors.black.withOpacity(0.3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.r),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _currentPage == _pages.length - 1 ? 'Get Started' : 'Continue',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.5,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Icon(
                              _currentPage == _pages.length - 1
                                  ? Icons.check_circle_rounded
                                  : Icons.arrow_forward_rounded,
                              size: 26.sp,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingPage page) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Responsive padding based on screen width
        final horizontalPadding = MediaQuery.of(context).size.width * 0.06 < 24.w
            ? MediaQuery.of(context).size.width * 0.06
            : 24.w;

        // Responsive vertical spacing based on screen height
        final verticalSpacingLarge = MediaQuery.of(context).size.height * 0.04 < 48.h
            ? MediaQuery.of(context).size.height * 0.04
            : 48.h;
        final verticalSpacingMedium = MediaQuery.of(context).size.height * 0.025 < 32.h
            ? MediaQuery.of(context).size.height * 0.025
            : 32.h;

        return FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: verticalSpacingMedium),

                        // Icon/Image with animated container
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: 200.w,
                            maxHeight: 200.w,
                          ),
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Container(
                              width: 200.w,
                              height: 200.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: RadialGradient(
                                  colors: page.useLightTheme
                                      ? [
                                          const Color(0xFF6366F1).withOpacity(0.15),
                                          const Color(0xFF6366F1).withOpacity(0.05),
                                        ]
                                      : [
                                          Colors.white.withOpacity(0.2),
                                          Colors.white.withOpacity(0.05),
                                        ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    blurRadius: 30,
                                    offset: const Offset(0, 15),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: page.imagePath != null
                                    ? Image.asset(
                                        page.imagePath!,
                                        width: 140.w,
                                        height: 140.w,
                                        fit: BoxFit.contain,
                                        errorBuilder: (context, error, stackTrace) {
                                          // Fallback to icon if image not found
                                          return Container(
                                            padding: EdgeInsets.all(32.w),
                                            decoration: BoxDecoration(
                                              color: page.useLightTheme ? const Color(0xFF6366F1) : Colors.white,
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: page.gradient.colors.first.withOpacity(0.3),
                                                  blurRadius: 20,
                                                  offset: const Offset(0, 10),
                                                ),
                                              ],
                                            ),
                                            child: Icon(
                                              page.icon,
                                              size: 72.sp,
                                              color: page.useLightTheme ? Colors.white : page.gradient.colors.first,
                                            ),
                                          );
                                        },
                                      )
                                    : Container(
                                        padding: EdgeInsets.all(32.w),
                                        decoration: BoxDecoration(
                                          color: page.useLightTheme ? const Color(0xFF6366F1) : Colors.white,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: page.gradient.colors.first.withOpacity(0.3),
                                              blurRadius: 20,
                                              offset: const Offset(0, 10),
                                            ),
                                          ],
                                        ),
                                        child: Icon(
                                          page.icon,
                                          size: 72.sp,
                                          color: page.useLightTheme ? Colors.white : page.gradient.colors.first,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: verticalSpacingLarge),

                        // Title
                        Text(
                          page.title,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w900,
                            color: page.useLightTheme ? const Color(0xFF1E293B) : Colors.white,
                            height: 1.2,
                            letterSpacing: -0.5,
                            shadows: page.useLightTheme
                                ? null
                                : [
                                    Shadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                          ),
                        ),
                        SizedBox(height: 12.h),

                        // Subtitle
                        Text(
                          page.subtitle,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: page.useLightTheme ? const Color(0xFF64748B) : Colors.white.withOpacity(0.95),
                            height: 1.3,
                            letterSpacing: 0.3,
                          ),
                        ),
                        SizedBox(height: 20.h),

                        // Description
                        Text(
                          page.description,
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                            color: page.useLightTheme ? const Color(0xFF475569) : Colors.white.withOpacity(0.85),
                            height: 1.5,
                            letterSpacing: 0.2,
                          ),
                        ),
                        SizedBox(height: verticalSpacingMedium),

                        // Features list
                        Flexible(
                          child: Container(
                            padding: EdgeInsets.all(20.w),
                            decoration: BoxDecoration(
                              color: page.useLightTheme
                                  ? const Color(0xFFF1F5F9)
                                  : Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(
                                color: page.useLightTheme
                                    ? const Color(0xFFE2E8F0)
                                    : Colors.white.withOpacity(0.2),
                                width: 1.5,
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: page.features.map((feature) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.h),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(6.w),
                                        decoration: BoxDecoration(
                                          color: page.useLightTheme ? const Color(0xFF6366F1) : Colors.white.withOpacity(0.9),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.check_rounded,
                                          size: 16.sp,
                                          color: page.useLightTheme ? Colors.white : page.gradient.colors.first,
                                        ),
                                      ),
                                      SizedBox(width: 12.w),
                                      Expanded(
                                        child: Text(
                                          feature,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                            color: page.useLightTheme ? const Color(0xFF334155) : Colors.white,
                                            height: 1.4,
                                            letterSpacing: 0.2,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        SizedBox(height: verticalSpacingMedium),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class OnboardingPage {
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final String? imagePath;
  final List<String> features;
  final LinearGradient gradient;
  final bool useLightTheme;

  OnboardingPage({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    this.imagePath,
    required this.features,
    required this.gradient,
    this.useLightTheme = false,
  });
}
