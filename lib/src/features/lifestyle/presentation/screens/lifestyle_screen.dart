import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/src/features/lifestyle/config/partner_config.dart';
import 'package:lazervault/src/features/lifestyle/domain/entities/flight_result.dart';
import 'package:lazervault/src/features/lifestyle/domain/entities/lifestyle_category.dart';
import 'package:lazervault/src/features/lifestyle/presentation/cubit/lifestyle_cubit.dart';
import 'package:lazervault/src/features/lifestyle/presentation/cubit/lifestyle_state.dart';
import 'package:lazervault/src/features/lifestyle/presentation/screens/booking_webview_screen.dart';
import 'package:lazervault/src/features/lifestyle/presentation/screens/flight_search_screen.dart';
import 'package:lazervault/src/features/lifestyle/presentation/screens/hotel_search_screen.dart';
import 'package:lazervault/src/features/lifestyle/presentation/screens/partner_webview_screen.dart';
import 'package:lazervault/src/features/lifestyle/presentation/screens/tour_search_screen.dart';

// ─── Icon mapping for backend categories ───────────────────────────────────────
const _categoryIcons = <String, IconData>{
  'flights': Icons.flight_takeoff,
  'hotels': Icons.hotel,
  'tours': Icons.explore,
  'movies': Icons.movie,
  'dining': Icons.restaurant,
  'wellness': Icons.spa,
  'shopping': Icons.shopping_bag,
  'fitness': Icons.fitness_center,
  'sports': Icons.sports_soccer,
  'education': Icons.school,
  'gift_cards': Icons.card_giftcard,
  'premium': Icons.diamond,
  'entertainment': Icons.celebration,
  'music': Icons.music_note,
  'gaming': Icons.sports_esports,
};

// ─── Promo data ────────────────────────────────────────────────────────────────
class _Promo {
  final String title;
  final String subtitle;
  final IconData icon;
  final List<Color> gradient;

  const _Promo({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.gradient,
  });
}

const _promos = [
  _Promo(
    title: 'Travel Deals',
    subtitle: 'Exclusive flight & hotel discounts',
    icon: Icons.flight_takeoff,
    gradient: [Color(0xFF1A237E), Color(0xFF0D47A1)],
  ),
  _Promo(
    title: 'Entertainment',
    subtitle: 'Movies, sports & live events',
    icon: Icons.movie_filter,
    gradient: [Color(0xFF4A148C), Color(0xFF7B1FA2)],
  ),
  _Promo(
    title: 'Dining & Food',
    subtitle: 'Restaurant reservations & discounts',
    icon: Icons.restaurant_menu,
    gradient: [Color(0xFFBF360C), Color(0xFFE65100)],
  ),
  _Promo(
    title: 'Wellness',
    subtitle: 'Spa, fitness & self-care perks',
    icon: Icons.spa,
    gradient: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
  ),
];

// ─── Main Screen ───────────────────────────────────────────────────────────────
class NewLifestyleScreen extends StatefulWidget {
  const NewLifestyleScreen({super.key});

  @override
  State<NewLifestyleScreen> createState() => _NewLifestyleScreenState();
}

class _NewLifestyleScreenState extends State<NewLifestyleScreen> {
  bool _isNavigating = false;
  int _currentPromo = 0;

  // ── Partner helpers ──────────────────────────────────────────────────────────

  String _mapCountryToPartnerKey(String countryCode) {
    if (countryCode == 'GB') return 'UK';
    return countryCode;
  }

  void _onPartnerTap(PartnerConfig partner) {
    if (_isNavigating) return;

    if (partner.requiresAuth) {
      _showDialog(
        title: 'Premium Feature',
        message: 'Please upgrade your account to access premium partner services.',
      );
      return;
    }

    final country = serviceLocator<LocaleManager>().currentCountry;
    final partnerKey = _mapCountryToPartnerKey(country);
    final localeConfig = partner.locales[partnerKey] ?? partner.locales['DEFAULT'];

    if (localeConfig == null) {
      _showDialog(
        title: 'Service Unavailable',
        message: 'This service is not available in your region yet.',
      );
      return;
    }

    _isNavigating = true;
    HapticFeedback.lightImpact();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PartnerWebViewScreen(
          url: localeConfig.url,
          title: partner.name,
          deepLink: localeConfig.deepLink,
        ),
      ),
    ).then((_) {
      if (mounted) _isNavigating = false;
    });
  }

  void _showDialog({required String title, required String message}) {
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        content: Text(message, style: const TextStyle(color: Color(0xFF9CA3AF))),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK', style: TextStyle(color: Color(0xFF3B82F6))),
          ),
        ],
      ),
    );
  }

  // ── Category tap → bottom sheet ──────────────────────────────────────────────

  void _onCategoryTap(LifestyleCategory category) {
    HapticFeedback.lightImpact();
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => _CategoryBottomSheet(
        category: category,
        onExplore: () {
          Navigator.of(context).pop(); // close sheet
          _navigateCategory(category);
        },
      ),
    );
  }

  void _navigateCategory(LifestyleCategory category) {
    if (_isNavigating) return;
    _isNavigating = true;

    final id = category.id.toLowerCase();
    Widget? screen;

    if (id == 'flights') {
      screen = const FlightSearchScreen();
    } else if (id == 'hotels') {
      screen = const HotelSearchScreen();
    } else if (id == 'tours') {
      screen = const TourSearchScreen();
    }

    if (screen != null) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => screen!)).then((_) {
        if (mounted) _isNavigating = false;
      });
      return;
    }

    // Try matching to a partner
    final partner = LifestylePartners.getPartner(id);
    if (partner != null) {
      _isNavigating = false;
      _onPartnerTap(partner);
      return;
    }

    _isNavigating = false;
    _showDialog(
      title: category.name,
      message: 'Coming soon! We\'re working on bringing you the best ${category.name.toLowerCase()} perks.',
    );
  }

  void _onFlightDealTap(FlightResult flight) {
    if (flight.affiliateUrl.isEmpty) return;
    HapticFeedback.lightImpact();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BookingWebViewScreen(
          url: flight.affiliateUrl,
          title: '${flight.origin} → ${flight.destination}',
        ),
      ),
    );
  }

  // ── Build ────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: BlocConsumer<LifestyleCubit, LifestyleState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is LifestyleLoading || state is LifestyleInitial) {
              return _buildLoadingState();
            }
            if (state is LifestyleError) {
              return _buildErrorState(state.message);
            }
            if (state is LifestyleCategoriesLoaded) {
              return _buildContent(state);
            }
            return _buildLoadingState();
          },
        ),
      ),
    );
  }

  // ── Loading shimmer ──────────────────────────────────────────────────────────

  Widget _buildLoadingState() {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF1F1F1F),
      highlightColor: const Color(0xFF2D2D2D),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        children: [
          // Title placeholder
          Container(
            width: 180.w,
            height: 28.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            width: 120.w,
            height: 16.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6.r),
            ),
          ),
          SizedBox(height: 24.h),
          // Carousel placeholder
          Container(
            height: 180.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
          SizedBox(height: 24.h),
          // Category grid placeholder
          Container(
            width: 140.w,
            height: 20.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6.r),
            ),
          ),
          SizedBox(height: 12.h),
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12.h,
            crossAxisSpacing: 12.w,
            childAspectRatio: 1,
            children: List.generate(
              6,
              (_) => Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),
            ),
          ),
          SizedBox(height: 24.h),
          // More placeholders
          Container(
            height: 120.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
        ],
      ),
    );
  }

  // ── Error state ──────────────────────────────────────────────────────────────

  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cloud_off, size: 64.sp, color: const Color(0xFF9CA3AF)),
            SizedBox(height: 16.h),
            Text(
              'Something went wrong',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            ElevatedButton.icon(
              onPressed: () => context.read<LifestyleCubit>().loadCategories(),
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Main content ─────────────────────────────────────────────────────────────

  Widget _buildContent(LifestyleCategoriesLoaded state) {
    return RefreshIndicator(
      onRefresh: () => context.read<LifestyleCubit>().loadCategories(),
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        children: [
          // Title
          Text(
            'Lifestyle & Perks',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Travel, experiences & exclusive deals',
            style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp),
          ),
          SizedBox(height: 20.h),

          // Promotions carousel
          _buildPromotionsCarousel(),
          SizedBox(height: 24.h),

          // Categories from backend
          _buildSectionHeader('Explore Categories'),
          SizedBox(height: 12.h),
          _buildCategoryGrid(state.categories),
          SizedBox(height: 24.h),

          // Cheap flight deals (hidden if empty)
          if (state.cheapFlights.isNotEmpty) ...[
            _buildSectionHeader('Flight Deals'),
            SizedBox(height: 4.h),
            Text(
              'Great prices found near you',
              style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 13.sp),
            ),
            SizedBox(height: 12.h),
            _buildCheapFlightsDeals(state.cheapFlights),
            SizedBox(height: 24.h),
          ],

          // Partner services
          Divider(color: const Color(0xFF2D2D2D), height: 1.h),
          SizedBox(height: 24.h),
          _buildSectionHeader('Partner Services'),
          SizedBox(height: 4.h),
          Text(
            'Tap to visit our trusted partners',
            style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 13.sp),
          ),
          SizedBox(height: 12.h),
          _buildPartnerServices(),
          SizedBox(height: 24.h),

          // Premium experiences
          _buildPremiumExperiences(),
          SizedBox(height: 20.h),

          // Gift cards
          _buildFeaturedGiftCards(),
          SizedBox(height: 20.h),

          // Exclusive offers
          if (state.categories.length >= 2) ...[
            _buildSectionHeader('Exclusive Offers'),
            SizedBox(height: 12.h),
            _buildExclusiveOffers(state.categories),
            SizedBox(height: 20.h),
          ],

          // Bottom padding for nav bar
          SizedBox(height: 80.h),
        ],
      ),
    );
  }

  // ── Section header ───────────────────────────────────────────────────────────

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // ── Promotions carousel ──────────────────────────────────────────────────────

  Widget _buildPromotionsCarousel() {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: _promos.length,
          options: CarouselOptions(
            height: 170.h,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
            enlargeCenterPage: true,
            viewportFraction: 0.92,
            onPageChanged: (index, _) => setState(() => _currentPromo = index),
          ),
          itemBuilder: (_, index, __) {
            final promo = _promos[index];
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: promo.gradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.r),
              ),
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(promo.icon, color: Colors.white.withValues(alpha: 0.9), size: 36.sp),
                  SizedBox(height: 12.h),
                  Text(
                    promo.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    promo.subtitle,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        SizedBox(height: 10.h),
        // Dot indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _promos.length,
            (i) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: EdgeInsets.symmetric(horizontal: 3.w),
              width: _currentPromo == i ? 20.w : 6.w,
              height: 6.h,
              decoration: BoxDecoration(
                color: _currentPromo == i
                    ? const Color(0xFF3B82F6)
                    : const Color(0xFF9CA3AF).withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(3.r),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ── Category grid ────────────────────────────────────────────────────────────

  Widget _buildCategoryGrid(List<LifestyleCategory> categories) {
    if (categories.isEmpty) {
      return Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Column(
          children: [
            Icon(Icons.category_outlined, size: 40.sp, color: const Color(0xFF9CA3AF)),
            SizedBox(height: 12.h),
            Text(
              'No categories available',
              style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp),
            ),
            SizedBox(height: 4.h),
            Text(
              'Pull to refresh and try again',
              style: TextStyle(color: const Color(0xFF9CA3AF).withValues(alpha: 0.6), fontSize: 12.sp),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12.h,
        crossAxisSpacing: 12.w,
        childAspectRatio: 0.95,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final cat = categories[index];
        final icon = _categoryIcons[cat.id.toLowerCase()] ?? Icons.category;
        return Semantics(
          button: true,
          label: '${cat.name} category',
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _onCategoryTap(cat),
              borderRadius: BorderRadius.circular(14.r),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 52.w,
                    height: 52.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1F1F1F),
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(
                        color: const Color(0xFF2D2D2D),
                        width: 0.5,
                      ),
                    ),
                    child: Icon(icon, color: const Color(0xFF3B82F6), size: 26.sp),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    cat.name,
                    style: TextStyle(color: Colors.white, fontSize: 12.sp),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ── Cheap flights deals (horizontal) ─────────────────────────────────────────

  Widget _buildCheapFlightsDeals(List<FlightResult> flights) {
    return SizedBox(
      height: 160.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: flights.length,
        separatorBuilder: (_, __) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          final f = flights[index];
          return GestureDetector(
            onTap: () => _onFlightDealTap(f),
            child: Container(
              width: 220.w,
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(color: const Color(0xFF2D2D2D)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Route
                  Row(
                    children: [
                      Text(
                        f.origin,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6.w),
                        child: Icon(Icons.arrow_forward, color: const Color(0xFF9CA3AF), size: 14.sp),
                      ),
                      Text(
                        f.destination,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  // Airline & stops
                  Text(
                    '${f.airline} · ${f.stopsLabel}',
                    style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 12.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    f.formattedDuration,
                    style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 12.sp),
                  ),
                  const Spacer(),
                  // Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${f.currency} ${f.price.toStringAsFixed(0)}',
                        style: TextStyle(
                          color: const Color(0xFF10B981),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, color: const Color(0xFF3B82F6), size: 14.sp),
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

  // ── Partner services grid ────────────────────────────────────────────────────

  static const _partnerIcons = <String, IconData>{
    'flight': Icons.flight,
    'hotel': Icons.hotel,
    'movie': Icons.movie,
    'card_giftcard': Icons.card_giftcard,
    'restaurant': Icons.restaurant,
    'spa': Icons.spa,
    'shopping_bag': Icons.shopping_bag,
    'diamond': Icons.diamond,
    'sports_soccer': Icons.sports_soccer,
    'fitness_center': Icons.fitness_center,
    'school': Icons.school,
  };

  Widget _buildPartnerServices() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12.h,
        crossAxisSpacing: 12.w,
        childAspectRatio: 0.9,
      ),
      itemCount: LifestylePartners.partners.length,
      itemBuilder: (context, index) {
        final partner = LifestylePartners.partners[index];
        final iconData = _partnerIcons[partner.icon] ?? Icons.open_in_new;
        return Semantics(
          button: true,
          label: '${partner.name} partner service',
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _onPartnerTap(partner),
              borderRadius: BorderRadius.circular(14.r),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 52.w,
                    height: 52.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1F1F1F),
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Icon(iconData, color: const Color(0xFF9CA3AF), size: 26.sp),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    partner.name,
                    style: TextStyle(color: Colors.white, fontSize: 12.sp),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ── Premium experiences card ─────────────────────────────────────────────────

  Widget _buildPremiumExperiences() {
    return GestureDetector(
      onTap: () {
        final partner = LifestylePartners.getPartner('premium');
        if (partner != null) {
          _onPartnerTap(partner);
        }
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: const Color(0xFFFFD700).withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.diamond, color: const Color(0xFFFFD700), size: 20.sp),
                      SizedBox(width: 8.w),
                      Text(
                        'Premium Experiences',
                        style: TextStyle(
                          color: const Color(0xFFFFD700),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'VIP access to exclusive events, luxury dining & travel upgrades',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            Icon(Icons.arrow_forward_ios, color: const Color(0xFFFFD700), size: 18.sp),
          ],
        ),
      ),
    );
  }

  // ── Gift cards card ──────────────────────────────────────────────────────────

  Widget _buildFeaturedGiftCards() {
    return GestureDetector(
      onTap: () {
        final partner = LifestylePartners.getPartner('gift_cards');
        if (partner != null) {
          _onPartnerTap(partner);
        }
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF2A1A3E), Color(0xFF1A2A4E)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: const Color(0xFF7C3AED).withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.card_giftcard, color: const Color(0xFF7C3AED), size: 20.sp),
                      SizedBox(width: 8.w),
                      Text(
                        'Gift Cards',
                        style: TextStyle(
                          color: const Color(0xFF7C3AED),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Send gift cards to friends & family from top brands',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            Icon(Icons.arrow_forward_ios, color: const Color(0xFF7C3AED), size: 18.sp),
          ],
        ),
      ),
    );
  }

  // ── Exclusive offers ─────────────────────────────────────────────────────────

  Widget _buildExclusiveOffers(List<LifestyleCategory> categories) {
    final items = categories.take(3).toList();
    return Column(
      children: items.map((cat) {
        final icon = _categoryIcons[cat.id.toLowerCase()] ?? Icons.local_offer;
        return Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _navigateCategory(cat),
              borderRadius: BorderRadius.circular(14.r),
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(color: const Color(0xFF2D2D2D)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44.w,
                      height: 44.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFF3B82F6).withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(icon, color: const Color(0xFF3B82F6), size: 22.sp),
                    ),
                    SizedBox(width: 14.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cat.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            cat.description.isNotEmpty
                                ? cat.description
                                : 'Explore ${cat.name.toLowerCase()} deals',
                            style: TextStyle(
                              color: const Color(0xFF9CA3AF),
                              fontSize: 12.sp,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios, color: const Color(0xFF9CA3AF), size: 14.sp),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

// ─── Category bottom sheet ─────────────────────────────────────────────────────

class _CategoryBottomSheet extends StatelessWidget {
  final LifestyleCategory category;
  final VoidCallback onExplore;

  const _CategoryBottomSheet({
    required this.category,
    required this.onExplore,
  });

  @override
  Widget build(BuildContext context) {
    final icon = _categoryIcons[category.id.toLowerCase()] ?? Icons.category;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFF9CA3AF).withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 20.h),
            // Icon + name
            Container(
              width: 64.w,
              height: 64.w,
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: Icon(icon, color: const Color(0xFF3B82F6), size: 32.sp),
            ),
            SizedBox(height: 16.h),
            Text(
              category.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (category.description.isNotEmpty) ...[
              SizedBox(height: 8.h),
              Text(
                category.description,
                style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp),
                textAlign: TextAlign.center,
              ),
            ],
            if (category.providers.isNotEmpty) ...[
              SizedBox(height: 12.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 6.h,
                alignment: WrapAlignment.center,
                children: category.providers.map((p) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2D2D2D),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      p,
                      style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 12.sp),
                    ),
                  );
                }).toList(),
              ),
            ],
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onExplore,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                ),
                child: Text(
                  'Explore ${category.name}',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
