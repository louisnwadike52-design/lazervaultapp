import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/data/app_data.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late CarouselSliderController carouselController;
  int currentPage = 0;
  bool isLastPage = false;
  final int totalSlides = AppData.onboardingSlides.length;

  @override
  void initState() {
    super.initState();
    carouselController = CarouselSliderController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _nextSlide() {
    if (!isLastPage) {
      carouselController.nextPage();
    }
  }

  void _gotoSignUp() async {
    // Save that the user has seen onboarding
    const storage = FlutterSecureStorage();
    await storage.write(key: 'has_seen_onboarding', value: 'true');

    // Navigate to sign up screen
    Get.offAllNamed(AppRoutes.signUp);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {},
      builder: (context, authState) {
        return Scaffold(
          body: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            color: AppData.onboardingSlides[currentPage].backgroundColor,
            child: SafeArea(
              child: Column(
                children: [
                  // Top bar with logo and skip button
                  _buildTopBar(),

                  // Main content
                  Expanded(
                    child: _buildContent(),
                  ),

                  // Bottom navigation
                  _buildBottomNavigation(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // LazerVault Logo
          Image.asset(
            AppData.appLogo,
            height: 40.h,
            width: 40.h,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 40.h,
                width: 40.h,
                decoration: BoxDecoration(
                  color: AppData.primaryColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.account_balance_wallet,
                  color: Colors.white,
                  size: 24.sp,
                ),
              );
            },
          ),

          // Skip button
          if (!isLastPage)
            TextButton(
              onPressed: _gotoSignUp,
              child: Text(
                'Skip',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppData.onboardingSlides[currentPage].textColor.withValues(alpha: 0.7),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return CarouselSlider(
      carouselController: carouselController,
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * 0.55,
        viewportFraction: 1.0,
        enableInfiniteScroll: false,
        onPageChanged: (index, reason) {
          setState(() {
            currentPage = index;
            isLastPage = currentPage == totalSlides - 1;
          });
        },
      ),
      items: AppData.onboardingSlides.asMap().entries.map((entry) {
        final index = entry.key;
        final slide = entry.value;
        return Builder(
          builder: (BuildContext context) {
            return OnboardingCarouselItem(
              slide: slide,
              isActive: index == currentPage,
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildBottomNavigation() {
    final slide = AppData.onboardingSlides[currentPage];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Page indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              totalSlides,
              (index) {
                bool isSelected = currentPage == index;
                return GestureDetector(
                  onTap: () {
                    carouselController.animateToPage(index);
                  },
                  child: AnimatedContainer(
                    width: isSelected ? 32.w : 10.w,
                    height: 10.h,
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? slide.textColor
                          : slide.textColor.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  ),
                );
              },
            ),
          ),

          SizedBox(height: 32.h),

          // Action button
          SizedBox(
            width: double.infinity,
            height: 56.h,
            child: ElevatedButton(
              onPressed: isLastPage ? _gotoSignUp : _nextSlide,
              style: ElevatedButton.styleFrom(
                backgroundColor: slide.textColor,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              child: Text(
                isLastPage ? 'Get Started' : 'Next',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingCarouselItem extends StatelessWidget {
  final OnboardingSlide slide;
  final bool isActive;

  const OnboardingCarouselItem({
    super.key,
    required this.slide,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 400),
      opacity: isActive ? 1.0 : 0.7,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon or Image
            _buildVisual(),

            SizedBox(height: 40.h),

            // Title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Text(
                slide.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: slide.textColor,
                  height: 1.2,
                ),
              ),
            ),

            SizedBox(height: 16.h),

            // Subtitle
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Text(
                slide.subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: slide.textColor.withValues(alpha: 0.7),
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVisual() {
    // Check if the image path is an asset
    if (slide.imagePath.startsWith('assets/')) {
      return Container(
        width: 200.w,
        height: 200.w,
        decoration: BoxDecoration(
          color: slide.textColor.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: ClipOval(
          child: Image.asset(
            slide.imagePath,
            width: 180.w,
            height: 180.w,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              // Fallback to icon if image fails to load
              return Icon(
                slide.icon ?? Icons.info_outline,
                size: 80.sp,
                color: slide.textColor,
              );
            },
          ),
        ),
      );
    }

    // Network image
    return Container(
      width: 280.w,
      height: 280.w,
      decoration: BoxDecoration(
        color: slide.textColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.r),
        child: Image.network(
          slide.imagePath,
          width: 280.w,
          height: 280.w,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(slide.textColor),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Icon(
              slide.icon ?? Icons.info_outline,
              size: 80.sp,
              color: slide.textColor,
            );
          },
        ),
      ),
    );
  }
}
