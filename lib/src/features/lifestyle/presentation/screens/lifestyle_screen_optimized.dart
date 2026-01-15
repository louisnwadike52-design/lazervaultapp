import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import '../../config/partner_config.dart';
import 'partner_webview_screen.dart';

/// Optimized Lifestyle Screen using WebView-based partner integrations
/// Reduces bundle size by removing hardcoded data and network images
/// Similar to Revolut's Points/Perks implementation
class LifestyleScreenOptimized extends StatelessWidget {
  const LifestyleScreenOptimized({super.key});

  /// Get the user's locale from LocaleManager
  LocaleManager get _localeManager => serviceLocator<LocaleManager>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),
                  SizedBox(height: 24.h),
                  _buildCategoriesGrid(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 150.h,
      floating: false,
      pinned: true,
      elevation: 0,
      backgroundColor: const Color(0xFF121212),
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
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF1E3A8A),
                    Color(0xFF3B82F6),
                  ],
                ),
              ),
            ),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                Text(
                  'Lifestyle',
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
                        'Partner services & rewards',
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
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Explore Services',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Tap a category to visit our trusted partners',
          style: TextStyle(
            color: Colors.white60,
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoriesGrid(BuildContext context) {
    final partners = LifestylePartners.partners;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
      ),
      itemCount: partners.length,
      itemBuilder: (context, index) {
        final partner = partners[index];
        return _buildCategoryCard(context, partner);
      },
    );
  }

  Widget _buildCategoryCard(BuildContext context, PartnerConfig partner) {
    // Get icon data from string
    IconData iconData;
    try {
      iconData = _getIconData(partner.icon);
    } catch (e) {
      iconData = Icons.category;
    }

    return GestureDetector(
      onTap: () => _openPartnerService(context, partner),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: Colors.grey[800]!,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                iconData,
                color: Colors.blue,
                size: 28.sp,
              ),
            ),
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text(
                partner.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'flight':
        return Icons.flight;
      case 'hotel':
        return Icons.hotel;
      case 'movie':
        return Icons.movie;
      case 'card_giftcard':
        return Icons.card_giftcard;
      case 'restaurant':
        return Icons.restaurant;
      case 'spa':
        return Icons.spa;
      case 'shopping_bag':
        return Icons.shopping_bag;
      case 'diamond':
        return Icons.diamond;
      case 'sports_soccer':
        return Icons.sports_soccer;
      case 'fitness_center':
        return Icons.fitness_center;
      case 'school':
        return Icons.school;
      default:
        return Icons.category;
    }
  }

  void _openPartnerService(BuildContext context, PartnerConfig partner) {
    // Get user's country from LocaleManager
    // Falls back to 'US' if not set or on error
    final userCountry = _localeManager.currentCountry.toUpperCase();

    final config = partner.locales[userCountry] ?? partner.locales['DEFAULT'];

    if (config == null) {
      _showNotAvailableDialog(context, partner.name);
      return;
    }

    // Check if deep link is available and can be opened
    if (config.deepLink != null) {
      // For now, always use WebView
      // In production, you could check if the app is installed and use deep link
    }

    // Open in WebView
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PartnerWebViewScreen(
          url: config.url,
          title: partner.name,
          deepLink: config.deepLink,
        ),
      ),
    );
  }

  void _showNotAvailableDialog(BuildContext context, String serviceName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text(
          'Service Unavailable',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          '$serviceName is not available in your region yet.',
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
