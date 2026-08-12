import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/shared_widgets/service_entrance_animation.dart';
import 'package:lazervault/core/theme/invoice_theme_colors.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/core/network/grpc_client.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/microservice_chat_icon.dart';
import 'package:lazervault/src/features/widgets/service_voice_button.dart';
import 'package:lazervault/src/generated/utility-payments.pb.dart' as pb;

class BillsHubScreen extends StatefulWidget {
  const BillsHubScreen({super.key});

  @override
  State<BillsHubScreen> createState() => _BillsHubScreenState();
}

class _BillsHubScreenState extends State<BillsHubScreen> {
  // Static tile registry — the type→(icon, route, copy) map is a client
  // concern and never comes from the backend. `type` matches the bill-service
  // catalogue's type string (see GetBillServices); `defaultVisible` is the
  // tile's visibility when the catalogue can't be consulted (fetch error /
  // timeout) or when the catalogue doesn't govern this type at all.
  //
  // The catalogue only governs: electricity, airtime, data, cable_tv,
  // internet, water, education. ePIN and betting are NOT in the catalogue, so
  // they are always shown (defaultVisible = true) regardless of the response.
  // Water defaults to hidden so a fetch failure never re-surfaces it (it only
  // appears when the catalogue explicitly reports it enabled).
  static const List<_BillType> _allTiles = [
    _BillType(
      type: 'airtime',
      icon: Icons.phone_android,
      title: 'Airtime',
      description: 'Top up any network',
      route: AppRoutes.airtime,
    ),
    _BillType(
      type: 'data',
      icon: Icons.wifi,
      title: 'Data Bundles',
      description: 'MTN, Airtel, Glo, 9mobile',
      route: AppRoutes.dataBundlesHome,
    ),
    _BillType(
      type: 'electricity',
      icon: Icons.electric_bolt,
      title: 'Electricity',
      description: 'Prepaid & postpaid bills',
      route: AppRoutes.electricityBillHome,
    ),
    _BillType(
      type: 'cable_tv',
      icon: Icons.tv,
      title: 'Cable TV',
      description: 'DStv, GOtv, Startimes',
      route: AppRoutes.cableTVHome,
    ),
    _BillType(
      type: 'internet',
      icon: Icons.router,
      title: 'Internet',
      description: 'Smile, Spectranet & more',
      route: AppRoutes.internetBillHome,
    ),
    _BillType(
      type: 'water',
      icon: Icons.water_drop,
      title: 'Water Bill',
      description: 'Water corporation bills',
      route: AppRoutes.waterBillHome,
      defaultVisible: false,
    ),
    _BillType(
      type: 'education',
      icon: Icons.school,
      title: 'Education PINs',
      description: 'WAEC, NECO & JAMB PINs',
      route: AppRoutes.educationHome,
    ),
    _BillType(
      type: 'epin',
      icon: Icons.confirmation_number,
      title: 'Recharge card printing',
      description: 'Generate airtime PINs',
      route: AppRoutes.epinHome,
    ),
    _BillType(
      type: 'betting',
      icon: Icons.sports_soccer,
      title: 'Fund betting account',
      description: 'Top up your betting wallet',
      route: AppRoutes.bettingHome,
    ),
  ];

  bool _loading = true;
  // Effective-enabled state keyed by bill type, populated from GetBillServices.
  // Empty + `_hasCatalogue == false` means we could not reach the service and
  // must fall back to each tile's defaultVisible.
  Map<String, bool> _enabledByType = const {};
  bool _hasCatalogue = false;

  @override
  void initState() {
    super.initState();
    _loadServices();
  }

  Future<void> _loadServices() async {
    try {
      // Utility payments rides the commerce gRPC client (same instance the
      // data-bundle / betting datasources use for GetDataPlans etc.).
      final client =
          serviceLocator<GrpcClient>(instanceName: 'commerceGrpcClient');
      final options = await client.callOptions;
      final resp = await client.utilityPaymentsClient
          .getBillServices(pb.GetBillServicesRequest(), options: options)
          .timeout(const Duration(seconds: 8));

      final map = <String, bool>{
        for (final s in resp.services) s.type: s.enabled,
      };
      if (!mounted) return;
      setState(() {
        _enabledByType = map;
        _hasCatalogue = true;
        _loading = false;
      });
    } catch (_) {
      // Never blank the hub: on any error/timeout, fall back to the default
      // tile set (every tile's defaultVisible).
      if (!mounted) return;
      setState(() {
        _enabledByType = const {};
        _hasCatalogue = false;
        _loading = false;
      });
    }
  }

  // A tile is visible when the catalogue reports its type enabled. Types the
  // catalogue doesn't govern (ePIN, betting) — and the whole grid when the
  // catalogue is unavailable — fall back to defaultVisible.
  bool _isVisible(_BillType b) {
    if (_hasCatalogue) {
      final enabled = _enabledByType[b.type];
      if (enabled != null) return enabled;
    }
    return b.defaultVisible;
  }

  @override
  Widget build(BuildContext context) {
    final bills = _allTiles.where(_isVisible).toList();

    return PopScope(
      // OS/Android back button routes to the dashboard, matching the
      // AppBar back button. Without this the system back would pop the
      // last pushed route which, after deep entries, is the wrong target.
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) Get.offAllNamed(AppRoutes.dashboard);
      },
      child: Scaffold(
      backgroundColor: InvoiceThemeColors.primaryBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.offAllNamed(AppRoutes.dashboard),
          icon: Container(
            padding: EdgeInsets.all(8.w),
            decoration: const BoxDecoration(
              color: InvoiceThemeColors.secondaryBackground,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 20.sp,
            ),
          ),
        ),
        title: Text(
          'Bills Hub',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actions: [
          // Chat icon — Utility Payments chat microservice (commerce chat agent).
          Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: MicroserviceChatIcon(
              serviceName: 'Utility Payments',
              sourceContext: 'bills',
              icon: Icons.chat_bubble_outline,
              iconColor: InvoiceThemeColors.primaryPurple,
              iconSize: 20,
              size: 40,
            ),
          ),
          // Voice icon — routes to the 'bills' voice agent.
          Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: ServiceVoiceButton(
              serviceName: 'bills',
              iconColor: InvoiceThemeColors.primaryPurple,
              backgroundColor: InvoiceThemeColors.primaryPurple,
              buttonSize: 40.w,
              iconSize: 20.sp,
            ),
          ),
        ],
      ),
      body: ServiceEntranceAnimation(
        child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderCard(),
              SizedBox(height: 16.h),
              if (_loading)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 48.h),
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        InvoiceThemeColors.primaryPurple,
                      ),
                    ),
                  ),
                )
              else
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.w,
                    mainAxisSpacing: 12.h,
                    // Compact tiles so bill types fit on screen at a glance.
                    childAspectRatio: 1.18,
                  ),
                  itemCount: bills.length,
                  itemBuilder: (context, index) {
                    final b = bills[index];
                    return _BillTile(
                      icon: b.icon,
                      title: b.title,
                      description: b.description,
                      onTap: () => Get.toNamed(b.route),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
      ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            InvoiceThemeColors.primaryPurple,
            InvoiceThemeColors.primaryPurple.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color:
                InvoiceThemeColors.primaryPurple.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50.w,
            height: 50.w,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.receipt_long,
              color: Colors.white,
              size: 24.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pay any bill, any time',
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Fast, secure & reliable bill payments',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: Colors.white.withValues(alpha: 0.9),
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

class _BillType {
  /// Bill-service catalogue type string (matches GetBillServices `type`).
  final String type;
  final IconData icon;
  final String title;
  final String description;
  final String route;

  /// Visibility when the catalogue can't be consulted (fetch error/timeout)
  /// or doesn't govern this type. Water defaults hidden; everything else shown.
  final bool defaultVisible;

  const _BillType({
    required this.type,
    required this.icon,
    required this.title,
    required this.description,
    required this.route,
    this.defaultVisible = true,
  });
}

class _BillTile extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  const _BillTile({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  State<_BillTile> createState() => _BillTileState();
}

class _BillTileState extends State<_BillTile> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: InvoiceThemeColors.secondaryBackground,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: _pressed
                ? InvoiceThemeColors.primaryPurple
                : InvoiceThemeColors.borderColor,
            width: _pressed ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: _pressed
                  ? InvoiceThemeColors.primaryPurple.withValues(alpha: 0.2)
                  : Colors.black.withValues(alpha: 0.1),
              blurRadius: _pressed ? 15 : 8,
              offset: _pressed ? const Offset(0, 6) : const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    InvoiceThemeColors.primaryPurple
                        .withValues(alpha: 0.2),
                    InvoiceThemeColors.primaryPurple
                        .withValues(alpha: 0.1),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  widget.icon,
                  size: 22.sp,
                  color: InvoiceThemeColors.primaryPurple,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              widget.title,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              widget.description,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                fontSize: 10.sp,
                color: InvoiceThemeColors.textGray400,
                height: 1.25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
