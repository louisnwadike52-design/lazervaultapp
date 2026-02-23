import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/lifestyle/config/partner_config.dart';
import 'package:lazervault/src/features/lifestyle/presentation/screens/partner_webview_screen.dart';

class _BillQuickAction {
  final IconData icon;
  final String label;
  final String route;

  const _BillQuickAction({
    required this.icon,
    required this.label,
    required this.route,
  });
}

const _billActions = [
  _BillQuickAction(icon: Icons.bolt, label: 'Electricity', route: AppRoutes.electricityBillHome),
  _BillQuickAction(icon: Icons.phone_android, label: 'Airtime', route: AppRoutes.airtime),
  _BillQuickAction(icon: Icons.signal_cellular_alt, label: 'Data', route: AppRoutes.dataBundlesHome),
  _BillQuickAction(icon: Icons.tv, label: 'Cable TV', route: AppRoutes.cableTVHome),
  _BillQuickAction(icon: Icons.language, label: 'Internet', route: AppRoutes.internetBillHome),
  _BillQuickAction(icon: Icons.water_drop, label: 'Water', route: AppRoutes.waterBillHome),
  _BillQuickAction(icon: Icons.school, label: 'Education', route: AppRoutes.educationHome),
  _BillQuickAction(icon: Icons.card_giftcard, label: 'Gift Cards', route: AppRoutes.giftCards),
];

const _partnerIcons = <String, IconData>{
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

class NewLifestyleScreen extends StatefulWidget {
  const NewLifestyleScreen({super.key});

  @override
  State<NewLifestyleScreen> createState() => _NewLifestyleScreenState();
}

class _NewLifestyleScreenState extends State<NewLifestyleScreen> {
  bool _isNavigating = false;

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
        content: Text(
          message,
          style: const TextStyle(color: Color(0xFF9CA3AF)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK', style: TextStyle(color: Color(0xFF3B82F6))),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => Future<void>.value(),
          color: const Color(0xFF3B82F6),
          backgroundColor: const Color(0xFF1F1F1F),
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            children: [
              // Title
              Text(
                'Lifestyle',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Bills, travel & more',
                style: TextStyle(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 24.h),

              // Pay Bills section
              _buildSectionHeader(
                'Pay Bills',
                onSeeAll: () => Get.toNamed(AppRoutes.billsHub),
              ),
              SizedBox(height: 12.h),
              GridView.count(
                crossAxisCount: 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12.h,
                crossAxisSpacing: 8.w,
                childAspectRatio: 0.85,
                children: _billActions
                    .map((action) => _buildBillTile(action))
                    .toList(),
              ),

              SizedBox(height: 24.h),
              Divider(color: const Color(0xFF2D2D2D), height: 1.h),
              SizedBox(height: 24.h),

              // Travel & Lifestyle section
              _buildSectionHeader('Travel & Lifestyle'),
              SizedBox(height: 4.h),
              Text(
                'Tap to visit our trusted partners',
                style: TextStyle(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 13.sp,
                ),
              ),
              SizedBox(height: 12.h),
              GridView.builder(
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
                  return _buildPartnerTile(partner);
                },
              ),

              // Bottom padding to avoid nav overlap
              SizedBox(height: 80.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, {VoidCallback? onSeeAll}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (onSeeAll != null)
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onSeeAll,
              borderRadius: BorderRadius.circular(8.r),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                child: Text(
                  'See all',
                  style: TextStyle(
                    color: const Color(0xFF3B82F6),
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildBillTile(_BillQuickAction action) {
    return Semantics(
      button: true,
      label: 'Pay ${action.label}',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            HapticFeedback.lightImpact();
            Get.toNamed(action.route);
          },
          borderRadius: BorderRadius.circular(12.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  action.icon,
                  color: const Color(0xFF3B82F6),
                  size: 24.sp,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                action.label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.sp,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPartnerTile(PartnerConfig partner) {
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
                child: Icon(
                  iconData,
                  color: const Color(0xFF9CA3AF),
                  size: 26.sp,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                partner.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
