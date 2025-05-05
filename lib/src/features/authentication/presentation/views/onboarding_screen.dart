import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/data/app_data.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/presentation/views/onboarding_carousel.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  MotionTabBarController? _motionTabBarController;

  late CarouselController innerCarouselController;
  late CarouselSliderController outerCarouselController;
  int innerCurrentPage = 0;
  int outerCurrentPage = 0;
  bool isLastPage = false;
  final int totalSlides = AppData.outerStyleImages.length;

  @override
  void initState() {
    super.initState();
    innerCarouselController = CarouselController();
    outerCarouselController = CarouselSliderController();
  }

  @override
  void dispose() {
    _motionTabBarController?.dispose();
    super.dispose();
  }

  void _nextSlide() {
    setState(() {
      outerCarouselController.nextPage();
    });
  }

  void _gotoHomeScreen() {
    Get.offAllNamed(AppRoutes.signUp);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {},
      builder: (context, authState) {
        return Scaffold(
          body: _outerBannerSlider(),
        );
      },
    );
  }

  Widget _outerBannerSlider() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          flex: 5, // Ensures this part takes 5/6 of the available space
          child: Padding(
            padding: EdgeInsets.only(top: 30.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CarouselSlider(
                  carouselController: outerCarouselController,
                  options: CarouselOptions(
                    // autoPlay: true,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: true,
                    viewportFraction: 1.0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        outerCurrentPage = index;
                        isLastPage = outerCurrentPage == totalSlides - 1;
                      });
                    },
                    height: 400.h, // Allows height to expand based on content
                  ),
                  items: AppData.outerStyleImages.map((imagePath) {
                    return Builder(
                      builder: (BuildContext context) {
                        return OnboardingCarousel(
                          image: imagePath,
                          title: '100% Secure System',
                          subtitle:
                              "You can add your credit card & bank details here. Don't worry about it its fully secure.",
                        );
                      },
                    );
                  }).toList(),
                ),
                // SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    AppData.outerStyleImages.length,
                    (index) {
                      bool isSelected = outerCurrentPage == index;
                      return GestureDetector(
                        onTap: () {
                          outerCarouselController.animateToPage(index);
                        },
                        child: AnimatedContainer(
                          width: isSelected ? 30.w : 10.w,
                          height: 10.h,
                          margin: EdgeInsets.symmetric(
                            horizontal: isSelected ? 6 : 3,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.deepPurpleAccent
                                : Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
            flex: 2, // Ensures this part takes 1/6 of the available space
            child: Padding(
              padding: EdgeInsets.only(bottom: 40.h),
              child: isLastPage
                  ? Center(
                      child: ClipOval(
                        child: Material(
                          color: Colors
                              .transparent, // Ensures the Material widget doesn't add any color
                          child: InkWell(
                            onTap: () {
                              // Define the action to be taken when the image is tapped
                              _gotoHomeScreen();
                            },
                            child: Ink.image(
                              image:
                                  AssetImage('assets/images/start_button.png'),
                              width: 100.0, // Set the desired width
                              height: 105.0, // Set the desired height
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 20.w,
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            _gotoHomeScreen();
                          },
                          style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.grey[700],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                              )),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 8.0),
                            child: Text('Skip'),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _nextSlide();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 11, 128, 224),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                              )),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 8.0),
                            child: Text('Next'),
                          ),
                        ),
                      ],
                    ),
            )),
      ],
    );
  }
}
