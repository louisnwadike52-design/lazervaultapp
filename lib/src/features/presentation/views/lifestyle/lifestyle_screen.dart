import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class LifeStyleScreen extends StatefulWidget {
  const LifeStyleScreen({super.key});

  @override
  State<LifeStyleScreen> createState() => _LifeStyleScreenState();
}

class _LifeStyleScreenState extends State<LifeStyleScreen> {
  final CarouselSliderController _carouselController = CarouselSliderController();
  int _currentPromoIndex = 0;
  bool _isLoading = true;

  final List<LifestylePromo> _promos = [
    LifestylePromo(
      title: "Premium Travel",
      description: "Exclusive luxury travel deals",
      image: "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4",
      backgroundColor: Color(0xFF1E2A3B),
    ),
    LifestylePromo(
      title: "Entertainment Plus",
      description: "Movies, events & more",
      image: "https://images.unsplash.com/photo-1470229722913-7c0e2dbbafd3",
      backgroundColor: Color(0xFF2C1F3E),
    ),
    LifestylePromo(
      title: "Dining Delights",
      description: "Top restaurant offers",
      image: "https://images.unsplash.com/photo-1559339352-11d035aa65de",
      backgroundColor: Color(0xFF2D3B1F),
    ),
    LifestylePromo(
      title: "Wellness & Spa",
      description: "Premium wellness packages",
      image: "https://images.unsplash.com/photo-1540555700478-4be289fbecef",
      backgroundColor: Color(0xFF3B1F2D),
    ),
  ];

  final List<LifestyleCategory> _categories = [
    LifestyleCategory(
      title: "Flights",
      icon: Icons.flight,
      color: Color(0xFF4A90E2),
      items: [
        PerkItem(
          title: "International Flights",
          description: "Up to 40% cashback",
          image: "https://images.unsplash.com/photo-1436491865332-7a61a109cc05",
        ),
        PerkItem(
          title: "Domestic Flights",
          description: "Instant 15% discount",
          image: "https://images.unsplash.com/photo-1569154941061-e231b4725ef1",
        ),
      ],
    ),
    LifestyleCategory(
      title: "Hotels",
      icon: Icons.hotel,
      color: Color(0xFF66BB6A),
      items: [
        PerkItem(
          title: "Luxury Hotels",
          description: "5-star luxury stays",
          image: "https://source.unsplash.com/800x600/?luxury,hotel",
        ),
        PerkItem(
          title: "Holiday Packages",
          description: "All-inclusive deals",
          image: "https://source.unsplash.com/800x600/?holiday,resort",
        ),
        PerkItem(
          title: "Beach Resorts",
          description: "Exclusive beach getaways",
          image: "https://source.unsplash.com/800x600/?beach,resort",
        ),
      ],
    ),
    LifestyleCategory(
      title: "Movies",
      icon: Icons.movie_outlined,
      color: Color(0xFF9B51E0),
      items: [
        PerkItem(
          title: "Cinema Tickets",
          description: "Weekend offers",
          image: "assets/images/cinema.png",
        ),
      ],
    ),
    LifestyleCategory(
      title: "Gift Cards",
      icon: Icons.card_giftcard,
      color: Color(0xFFFF7043),
      items: [
        PerkItem(
          title: "Digital Gift Cards",
          description: "Instant delivery",
          image: "assets/images/gift_cards.png",
        ),
      ],
    ),
    LifestyleCategory(    
      title: "Dining",
      icon: Icons.restaurant,
      color: Color(0xFFEC407A),
      items: [
        PerkItem(
          title: "Restaurant Deals",
          description: "Up to 25% off",
          image: "assets/images/dining.png",
        ),
      ],
    ),
    LifestyleCategory(
      title: "Wellness",
      icon: Icons.spa,
      color: Color(0xFF9C27B0),
      items: [
        PerkItem(
          title: "Luxury Spa Days",
          description: "50% off on spa packages",
          image: "https://source.unsplash.com/800x600/?spa",
        ),
        PerkItem(
          title: "Fitness Centers",
          description: "Monthly membership deals",
          image: "https://source.unsplash.com/800x600/?gym",
        ),
      ],
    ),
    LifestyleCategory(
      title: "Shopping",
      icon: Icons.shopping_bag,
      color: Color(0xFF00BCD4),
      items: [
        PerkItem(
          title: "Fashion Deals",
          description: "Designer brands sale",
          image: "https://source.unsplash.com/800x600/?fashion",
        ),
      ],
    ),
    LifestyleCategory(
      title: "Premium",
      icon: Icons.diamond_outlined,
      color: Color(0xFFE91E63),
      items: [
        PerkItem(
          title: "VIP Access",
          description: "Exclusive events & venues",
          image: "https://source.unsplash.com/800x600/?vip,luxury",
        ),
        PerkItem(
          title: "Concierge Service",
          description: "24/7 personal assistance",
          image: "https://source.unsplash.com/800x600/?concierge,service",
        ),
      ],
    ),
    LifestyleCategory(
      title: "Sports",
      icon: Icons.sports_soccer,
      color: Color(0xFF4CAF50),
      items: [
        PerkItem(
          title: "Match Tickets",
          description: "Premium seating deals",
          image: "https://source.unsplash.com/800x600/?stadium,sports",
        ),
        PerkItem(
          title: "Sports Gear",
          description: "Exclusive discounts",
          image: "https://source.unsplash.com/800x600/?sports,equipment",
        ),
      ],
    ),
    LifestyleCategory(
      title: "Education",
      icon: Icons.school_outlined,
      color: Color(0xFF3F51B5),
      items: [
        PerkItem(
          title: "Online Courses",
          description: "Learn from experts",
          image: "https://source.unsplash.com/800x600/?education,learning",
        ),
      ],
    ),
    LifestyleCategory(
      title: "Fitness",
      icon: Icons.fitness_center,
      color: Color(0xFF2196F3),
      items: [
        PerkItem(
          title: "Premium Gyms",
          description: "50% off annual membership",
          image: "https://images.unsplash.com/photo-1534438327276-14e5300c3a48",
        ),
        PerkItem(
          title: "Personal Training",
          description: "First session free",
          image: "https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b",
        ),
        PerkItem(
          title: "CrossFit Classes",
          description: "20% off packages",
          image: "https://images.unsplash.com/photo-1541534741688-6078c6bfb5c5",
        ),
      ],
    ),
    LifestyleCategory(
      title: "Running",
      icon: Icons.directions_run,
      color: Color(0xFF00BFA5),
      items: [
        PerkItem(
          title: "Marathon Entry",
          description: "Early bird discount",
          image: "https://images.unsplash.com/photo-1552674605-db6ffd4facb5",
        ),
        PerkItem(
          title: "Running Gear",
          description: "30% off premium brands",
          image: "https://images.unsplash.com/photo-1539185441755-769473a23570",
        ),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    // Simulate data loading
    await Future.delayed(Duration(seconds: 2));
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF121212),
      child: _isLoading 
        ? _buildLoadingState()
        : RefreshIndicator(
            onRefresh: _loadData,
            child: CustomScrollView(
              slivers: [
                _buildAppBar(),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.h),
                      _buildPromotionsCarousel(),
                      _buildCategoryGrid(),
                      _buildFitnessSection(),
                      _buildPremiumExperiences(),
                      _buildTrendingExperiences(),
                      _buildSeasonalOffers(),
                      _buildFeaturedGiftCards(),
                      _buildPopularPerks(),
                      _buildExclusiveOffers(),
                      SizedBox(height: 32.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildLoadingState() {
    return Shimmer.fromColors(
      baseColor: Color(0xFF2A2D3E),
      highlightColor: Color(0xFF3D4054),
      child: Column(
        children: [
          Container(
            height: 120.h,
            color: Colors.white,
          ),
          SizedBox(height: 16.h),
          Container(
            height: 180.h,
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              color: Colors.white,
            ),
          ),
          // Add more shimmer placeholders
        ],
      ),
    );
  }

  Widget _buildNetworkImage(String url, {
    double? height,
    double? width,
    BoxFit fit = BoxFit.cover,
  }) {
    return CachedNetworkImage(
      imageUrl: url,
      height: height,
      width: width,
      fit: fit,
      placeholder: (context, url) => Container(
        color: Color(0xFF1E1E1E),
        child: Center(
          child: Icon(
            Icons.image_outlined,
            color: Colors.white24,
            size: 32.sp,
          ),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        color: Color(0xFF1E1E1E),
        child: Center(
          child: Icon(
            Icons.broken_image_outlined,
            color: Colors.white24,
            size: 32.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 150.h,
      floating: false,
      pinned: true,
      elevation: 0,
      backgroundColor: Color(0xFF121212),
      toolbarHeight: 80.h,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final bool isCollapsed = constraints.biggest.height <= 80.h;
          
          return FlexibleSpaceBar(
            titlePadding: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
              bottom: 16.h,
              top: isCollapsed ? 30.h : 0,
            ),
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF1A237E),
                    Color(0xFF0D47A1),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -50.w,
                    top: -20.h,
                    child: Container(
                      width: 200.w,
                      height: 200.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                Text(
                  'Lifestyle & Perks',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isCollapsed ? 20.sp : 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (!isCollapsed)
                  Column(
                    children: [
                      SizedBox(height: 4.h),
                      Text(
                        'Exclusive offers just for you',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: Row(
            children: [
              IconButton(
                icon: Stack(
                  children: [
                    Icon(Icons.notifications_outlined, color: Colors.white),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: EdgeInsets.all(4.r),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '2',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                onPressed: _showNotifications,
              ),
              GestureDetector(
                onTap: () {
                  // Handle user profile tap
                },
                child: Container(
                  margin: EdgeInsets.only(right: 16.w, left: 8.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: _buildNetworkImage(
                      "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde",
                      height: 36.h,
                      width: 36.h,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPromotionsCarousel() {
    return Column(
      children: [
        CarouselSlider(
          carouselController: _carouselController,
          options: CarouselOptions(
            height: 180.h,
            viewportFraction: 0.9,
            enlargeCenterPage: true,
            autoPlay: true,
            onPageChanged: (index, reason) {
              setState(() => _currentPromoIndex = index);
            },
          ),
          items: _promos.map((promo) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: promo.backgroundColor,
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.r),
                          child: _buildNetworkImage(
                            promo.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Colors.transparent,
                              promo.backgroundColor.withValues(alpha: 0.9),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              promo.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              promo.description,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }).toList(),
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _promos.asMap().entries.map((entry) {
            return Container(
              width: 8.w,
              height: 8.w,
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentPromoIndex == entry.key
                    ? Colors.blue
                    : Colors.white24,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCategoryGrid() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Categories',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 16.h,
            ),
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final category = _categories[index];
              return GestureDetector(
                onTap: () => _showCategoryDetails(category),
                child: Container(
                  decoration: BoxDecoration(
                    color: category.color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        category.icon,
                        color: category.color,
                        size: 32.sp,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        category.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showCategoryDetails(LifestyleCategory category) {
    Get.bottomSheet(
      Container(
        height: 0.7.sh,
        decoration: BoxDecoration(
          color: Color(0xFF1E1E1E),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              margin: EdgeInsets.symmetric(vertical: 12.h),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  Icon(category.icon, color: category.color, size: 24.sp),
                  SizedBox(width: 12.w),
                  Text(
                    category.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(16.w),
                itemCount: category.items.length,
                itemBuilder: (context, index) {
                  final item = category.items[index];
                  return _buildPerkCard(item);
                },
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildPerkCard(PerkItem perk) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Stack(
          children: [
            _buildNetworkImage(
              perk.image,
              height: 200.h,
              width: double.infinity,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.9),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      perk.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      perk.description,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularPerks() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Popular Perks',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 200.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.expand((c) => c.items).take(5).length,
              itemBuilder: (context, index) {
                final perk = _categories.expand((c) => c.items).toList()[index];
                return Container(
                  width: 160.w,
                  margin: EdgeInsets.only(right: 16.w),
                  decoration: BoxDecoration(
                    color: Color(0xFF2A2A2A),
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16.r),
                        ),
                        child: _buildNetworkImage(
                          perk.image,
                          height: 120.h,
                          width: double.infinity,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              perk.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              perk.description,
                              style: TextStyle(
                                color: Colors.white60,
                                fontSize: 12.sp,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExclusiveOffers() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Exclusive Offers',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(bottom: 16.h),
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Color(0xFF2A2A2A),
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 60.w,
                      height: 60.w,
                      decoration: BoxDecoration(
                        color: _categories[index].color.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(
                        _categories[index].icon,
                        color: _categories[index].color,
                        size: 30.sp,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Special ${_categories[index].title} Offer',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Limited time exclusive deal',
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white38,
                      size: 20.sp,
                    ),
                  ],
                ),
              );
            },
          ),
          SizedBox(height: 100.h),
        ],
      ),
    );
  }

  Widget _buildFeaturedGiftCards() {
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF2C3E50), Color(0xFF3498DB)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Featured Gift Cards',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildGiftCard('Amazon', Icons.card_giftcard, '10% off'),
                _buildGiftCard('Netflix', Icons.movie, '15% cashback'),
                _buildGiftCard('Spotify', Icons.music_note, '3 months free'),
                _buildGiftCard('Steam', Icons.games, '20% bonus'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGiftCard(String name, IconData icon, String offer) {
    return Container(
      width: 120.w,
      margin: EdgeInsets.only(right: 12.w),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 32.sp),
          SizedBox(height: 8.h),
          Text(
            name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            offer,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumExperiences() {
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF6A1B9A), Color(0xFF4A148C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: Offset(0, 10),
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
                'Premium Experiences',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  'VIP Only',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildPremiumCard(
                  'Private Jet',
                  'Exclusive charter services',
                  'https://images.unsplash.com/photo-1540962351504-03099e0a754b',
                  Icons.flight_takeoff,
                ),
                _buildPremiumCard(
                  'Yacht Party',
                  'Luxury yacht experiences',
                  'https://images.unsplash.com/photo-1567899378494-47b22a2ae96a',
                  Icons.sailing,
                ),
                _buildPremiumCard(
                  'Fine Dining',
                  'Michelin star restaurants',
                  'https://images.unsplash.com/photo-1414235077428-338989a2e8c0',
                  Icons.restaurant_menu,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumCard(String title, String description, String imageUrl, IconData icon) {
    return Container(
      width: 200.w,
      margin: EdgeInsets.only(right: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: Colors.white.withValues(alpha: 0.1),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: _buildNetworkImage(
              imageUrl,
              height: 250.h,
              width: 200.w,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.8),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 16.w,
            left: 16.w,
            right: 16.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(icon, color: Colors.white, size: 24.sp),
                    SizedBox(width: 8.w),
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingExperiences() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Trending Experiences',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'View All',
                  style: TextStyle(
                    color: Colors.blue[400],
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 280.h,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildTrendingCard(
                  'Skydiving Adventure',
                  '₤299',
                  'https://images.unsplash.com/photo-1521673461164-de300ebcfb17',
                  '4.9',
                  'Adrenaline rush guaranteed',
                ),
                _buildTrendingCard(
                  'Wine Tasting Tour',
                  '₤149',
                  'https://images.unsplash.com/photo-1506377247377-2a5b3b417ebb',
                  '4.8',
                  'Premium vineyard experience',
                ),
                _buildTrendingCard(
                  'Cooking Masterclass',
                  '₤89',
                  'https://images.unsplash.com/photo-1556910103-1c02745aae4d',
                  '4.7',
                  'Learn from top chefs',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingCard(String title, String price, String imageUrl, String rating, String subtitle) {
    return Container(
      width: 220.w,
      margin: EdgeInsets.only(right: 16.w),
      decoration: BoxDecoration(
        color: Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            child: Stack(
              children: [
                _buildNetworkImage(
                  imageUrl,
                  height: 160.h,
                  width: double.infinity,
                ),
                Positioned(
                  top: 12.h,
                  right: 12.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16.sp),
                        SizedBox(width: 4.w),
                        Text(
                          rating,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 12.sp,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: Colors.blue[700],
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        'Book Now',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeasonalOffers() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Summer Special',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Limited time offers',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.timer, color: Colors.white, size: 16.sp),
                    SizedBox(width: 4.w),
                    Text(
                      '48h left',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildSeasonalCard(
                  'Beach Resort',
                  '40% OFF',
                  'https://images.unsplash.com/photo-1573843981267-be1999ff37cd',
                  Icons.beach_access,
                ),
                _buildSeasonalCard(
                  'Water Sports',
                  '25% OFF',
                  'https://images.unsplash.com/photo-1502680390469-be75c86b636f',
                  Icons.surfing,
                ),
                _buildSeasonalCard(
                  'Pool Party',
                  '30% OFF',
                  'https://images.unsplash.com/photo-1595475207225-428b62bda831',
                  Icons.pool,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeasonalCard(String title, String discount, String imageUrl, IconData icon) {
    return Container(
      width: 160.w,
      margin: EdgeInsets.only(right: 16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: _buildNetworkImage(
              imageUrl,
              height: 200.h,
              width: 160.w,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.8),
                ],
              ),
            ),
          ),
          Positioned(
            top: 12.w,
            right: 12.w,
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.blue[700], size: 20.sp),
            ),
          ),
          Positioned(
            bottom: 12.w,
            left: 12.w,
            right: 12.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  discount,
                  style: TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showNotifications() {
    Get.bottomSheet(
      Container(
        height: 0.6.sh,
        decoration: BoxDecoration(
          color: Color(0xFF1E1E1E),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              margin: EdgeInsets.symmetric(vertical: 12.h),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Notifications',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Mark all as read',
                      style: TextStyle(
                        color: Colors.blue[400],
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                children: [
                  _buildNotificationItem(
                    'New Offer Available',
                    '50% off on Premium Gym Membership',
                    'https://images.unsplash.com/photo-1534438327276-14e5300c3a48',
                    '2m ago',
                    true,
                  ),
                  _buildNotificationItem(
                    'Marathon Registration',
                    'Early bird registration closing soon',
                    'https://images.unsplash.com/photo-1552674605-db6ffd4facb5',
                    '1h ago',
                    true,
                  ),
                  _buildNotificationItem(
                    'Wellness Update',
                    'Your fitness goals are on track',
                    'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b',
                    '3h ago',
                    false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildNotificationItem(String title, String description, String imageUrl, String time, bool isUnread) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: isUnread ? Color(0xFF2A2A2A) : Color(0xFF222222),
        borderRadius: BorderRadius.circular(12.r),
        border: isUnread
            ? Border.all(color: Colors.blue.withValues(alpha: 0.3))
            : null,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: _buildNetworkImage(
              imageUrl,
              height: 50.h,
              width: 50.h,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 14.sp,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  time,
                  style: TextStyle(
                    color: Colors.white38,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          if (isUnread)
            Container(
              width: 8.w,
              height: 8.w,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFitnessSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Fitness & Wellness',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.local_fire_department,
                      color: Colors.orange,
                      size: 16.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Popular',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          SizedBox(
            height: 200.h,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildFitnessCard(
                  'Premium Gym Access',
                  '50% Off Annual',
                  'https://images.unsplash.com/photo-1540497077202-7c8a3999166f',
                  '4.9',
                  '120+ Locations',
                  Icons.fitness_center,
                ),
                _buildFitnessCard(
                  'Personal Training',
                  'First Session Free',
                  'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b',
                  '4.8',
                  'Expert Trainers',
                  Icons.sports_gymnastics,
                ),
                _buildFitnessCard(
                  'Yoga Classes',
                  '30% Off Packages',
                  'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b',
                  '4.7',
                  'All Levels',
                  Icons.self_improvement,
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            'Fitness Programs',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 16.h,
            crossAxisSpacing: 16.w,
            childAspectRatio: 0.8,
            children: [
              _buildFitnessProgram(
                'HIIT Workout',
                '45 mins',
                'Burn 500 cal',
                'https://images.unsplash.com/photo-1601422407692-ec4eeec1d9b3',
                Colors.orange,
              ),
              _buildFitnessProgram(
                'Strength Training',
                '60 mins',
                'Build Muscle',
                'https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e',
                Colors.blue,
              ),
              _buildFitnessProgram(
                'Cardio Mix',
                '30 mins',
                'Heart Healthy',
                'https://images.unsplash.com/photo-1538805060514-97d9cc17730c',
                Colors.green,
              ),
              _buildFitnessProgram(
                'CrossFit',
                '50 mins',
                'Full Body',
                'https://images.unsplash.com/photo-1541534741688-6078c6bfb5c5',
                Colors.purple,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFitnessCard(String title, String offer, String imageUrl, String rating, String subtitle, IconData icon) {
    return Container(
      width: 280.w,
      margin: EdgeInsets.only(right: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
        ),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: _buildNetworkImage(
              imageUrl,
              height: 200.h,
              width: 280.w,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.8),
                ],
              ),
            ),
          ),
          Positioned(
            top: 16.w,
            right: 16.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 16.sp),
                  SizedBox(width: 4.w),
                  Text(
                    rating,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 16.w,
            left: 16.w,
            right: 16.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(icon, color: Colors.white, size: 24.sp),
                    SizedBox(width: 8.w),
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          offer,
                          style: TextStyle(
                            color: Colors.greenAccent,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          subtitle,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        'Join Now',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFitnessProgram(String title, String duration, String subtitle, String imageUrl, Color color) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: Color(0xFF2A2A2A),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: _buildNetworkImage(
              imageUrl,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.9),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(
                      Icons.timer_outlined,
                      color: color,
                      size: 14.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      duration,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    subtitle,
                    style: TextStyle(
                      color: color,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LifestylePromo {
  final String title;
  final String description;
  final String image;
  final Color backgroundColor;

  LifestylePromo({
    required this.title,
    required this.description,
    required this.image,
    required this.backgroundColor,
  });
}

class LifestyleCategory {
  final String title;
  final IconData icon;
  final Color color;
  final List<PerkItem> items;

  LifestyleCategory({
    required this.title,
    required this.icon,
    required this.color,
    required this.items,
  });
}

class PerkItem {
  final String title;
  final String description;
  final String image;

  PerkItem({
    required this.title,
    required this.description,
    required this.image,
  });
}
