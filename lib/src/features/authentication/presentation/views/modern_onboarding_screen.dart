import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lazervault/core/services/injection_container.dart';
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

  // Onboarding pages — unified dark theme.
  //
  // Each slide carries its own *accent* color (the icon halo + button tint
  // change per page), but every slide shares the same deep-black-to-dark
  // base gradient so the brand surface reads as one continuous experience
  // rather than five abruptly different screens.
  //
  // The legacy `imagePath` references (`assets/images/onboarding/*.png`)
  // pointed at files that never existed — the dir is empty — so we now
  // render the page icon as the canonical visual inside a tinted halo.
  // No more flickering error-builders falling back to a different style.
  final List<OnboardingPage> _pages = [
    OnboardingPage(
      title: 'Welcome to Lazervault',
      subtitle: 'Your all-in-one financial super app',
      description: 'Bank, save, send and invest from one trusted home — designed for how money actually moves today.',
      icon: Icons.account_balance_wallet_rounded,
      features: [
        'Multi-currency wallets out of the box',
        'Real-time transactions & receipts',
        'Bank-grade encryption, end to end',
      ],
      accent: const Color(0xFF6366F1),
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF0A0A0A), Color(0xFF111125), Color(0xFF0A0A0A)],
      ),
    ),
    OnboardingPage(
      title: 'Send money anywhere',
      subtitle: 'Local rails. Global reach.',
      description: 'Instant transfers within Nigeria and 50+ currencies abroad — at rates that respect your money.',
      icon: Icons.send_rounded,
      features: [
        'Domestic & international transfers',
        'Best-in-class FX, no hidden spread',
        'Live status from debit to delivery',
      ],
      accent: const Color(0xFF22D3EE),
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF0A0A0A), Color(0xFF0D1F26), Color(0xFF0A0A0A)],
      ),
    ),
    OnboardingPage(
      title: 'Grow your wealth',
      subtitle: 'Stocks, crypto and smart vaults',
      description: 'Buy, sell and auto-invest from one dashboard — backed by analytics that show what your money is actually doing.',
      icon: Icons.trending_up_rounded,
      features: [
        'Stocks & vetted crypto markets',
        'Auto-save, lock-funds, crowdfund',
        'Portfolio insights & performance',
      ],
      accent: const Color(0xFF34D399),
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF0A0A0A), Color(0xFF0C2018), Color(0xFF0A0A0A)],
      ),
    ),
    OnboardingPage(
      title: 'Pay every bill',
      subtitle: 'Airtime, data, electricity and more',
      description: 'One tap for the bills that used to take five apps. Automatic, scheduled and reliable.',
      icon: Icons.payment_rounded,
      features: [
        'Utilities, data, airtime & cable TV',
        'Auto-recharge so it never lapses',
        'Split bills & shared expenses',
      ],
      accent: const Color(0xFFFB923C),
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF0A0A0A), Color(0xFF1F1408), Color(0xFF0A0A0A)],
      ),
    ),
    OnboardingPage(
      title: 'Yours, safely',
      subtitle: 'AI protection that has your back',
      description: 'Face, voice and PIN unlock — plus an AI layer watching for fraud the moment it appears.',
      icon: Icons.security_rounded,
      features: [
        'Face, voice & biometric login',
        'AI fraud detection, 24/7',
        'End-to-end encryption everywhere',
      ],
      accent: const Color(0xFFEC4899),
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF0A0A0A), Color(0xFF1F0F1A), Color(0xFF0A0A0A)],
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
    final storage = serviceLocator<FlutterSecureStorage>();
    await storage.write(key: 'has_seen_onboarding', value: 'true');
    // Honour the active auth_mode: phone+passcode → phone flow (no password),
    // email mode → the email/password signup.
    Get.offAllNamed(AppRoutes.signupEntry);
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
                    // Skip button — subtle ghost pill so it doesn't compete
                    // with the primary CTA at the bottom.
                    TextButton(
                      onPressed: _completeOnboarding,
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.white.withValues(alpha: 0.08),
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.r),
                        ),
                      ),
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.3,
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
                    // Page indicator — tinted with the current page's accent
                    // so the eye follows the same color from indicator to
                    // CTA below.
                    SmoothPageIndicator(
                      controller: _pageController,
                      count: _pages.length,
                      effect: ExpandingDotsEffect(
                        activeDotColor: _pages[_currentPage].accent,
                        dotColor: Colors.white.withValues(alpha: 0.22),
                        dotHeight: 8.h,
                        dotWidth: 8.w,
                        expansionFactor: 4,
                        spacing: 7.w,
                      ),
                    ),
                    SizedBox(height: 28.h),

                    // Next / Get Started — pill-rounded, accent-tinted so
                    // each slide has its own moment without breaking the
                    // unified dark surface.
                    SizedBox(
                      width: double.infinity,
                      height: 56.h,
                      child: ElevatedButton(
                        onPressed: _nextPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _pages[_currentPage].accent,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shadowColor:
                              _pages[_currentPage].accent.withValues(alpha: 0.35),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28.r),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _currentPage == _pages.length - 1
                                  ? 'Get Started'
                                  : 'Continue',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.3,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Icon(
                              _currentPage == _pages.length - 1
                                  ? Icons.check_rounded
                                  : Icons.arrow_forward_rounded,
                              size: 22.sp,
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

                        // Icon visual — accent halo + inner pill chip with
                        // the page's themed icon. Replaces the legacy
                        // imagePath fallback (those assets never shipped).
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: 220.w,
                            maxHeight: 220.w,
                          ),
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Container(
                              width: 220.w,
                              height: 220.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: RadialGradient(
                                  colors: [
                                    page.accent.withValues(alpha: 0.28),
                                    page.accent.withValues(alpha: 0.0),
                                  ],
                                  stops: const [0.4, 1.0],
                                ),
                              ),
                              child: Center(
                                child: Container(
                                  padding: EdgeInsets.all(34.w),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.06),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: page.accent.withValues(alpha: 0.6),
                                      width: 1.4,
                                    ),
                                  ),
                                  child: Icon(
                                    page.icon,
                                    size: 76.sp,
                                    color: page.accent,
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
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            height: 1.2,
                            letterSpacing: -0.6,
                          ),
                        ),
                        SizedBox(height: 10.h),

                        // Subtitle — accent-tinted to draw the eye to the
                        // page's themed promise before the longer body.
                        Text(
                          page.subtitle,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: page.accent.withValues(alpha: 0.95),
                            height: 1.3,
                            letterSpacing: 0.4,
                          ),
                        ),
                        SizedBox(height: 16.h),

                        // Description
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Text(
                            page.description,
                            textAlign: TextAlign.center,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.white.withValues(alpha: 0.78),
                              height: 1.55,
                              letterSpacing: 0.1,
                            ),
                          ),
                        ),
                        SizedBox(height: verticalSpacingMedium),

                        // Features list — frosted dark card with accented
                        // check chips. Lighter border than before so it
                        // sits on the dark surface without overpowering it.
                        Flexible(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 18.w, vertical: 16.h),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.04),
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.08),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: page.features.map((feature) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 7.h),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(5.w),
                                        decoration: BoxDecoration(
                                          color: page.accent
                                              .withValues(alpha: 0.22),
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: page.accent
                                                .withValues(alpha: 0.6),
                                            width: 1,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.check_rounded,
                                          size: 14.sp,
                                          color: page.accent,
                                        ),
                                      ),
                                      SizedBox(width: 12.w),
                                      Expanded(
                                        child: Text(
                                          feature,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 13.5.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white
                                                .withValues(alpha: 0.92),
                                            height: 1.4,
                                            letterSpacing: 0.1,
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
  final List<String> features;
  final LinearGradient gradient;
  // Per-page accent color — drives the icon halo, indicator dots and the
  // primary CTA. Distinguishes slides without abandoning the unified dark
  // base. Tap-points (button + dots) use the accent; surfaces use white.
  final Color accent;

  OnboardingPage({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.features,
    required this.gradient,
    required this.accent,
  });
}
