import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/theme/invoice_theme_colors.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/microservice_chat_icon.dart';
import 'package:lazervault/src/features/widgets/service_voice_button.dart';

class BillsHubScreen extends StatelessWidget {
  const BillsHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bills = <_BillType>[
      _BillType(
        icon: Icons.electric_bolt,
        title: 'Electricity',
        description: 'Prepaid & postpaid bills',
        route: AppRoutes.electricityBillHome,
      ),
      _BillType(
        icon: Icons.phone_android,
        title: 'Airtime',
        description: 'Top up any network',
        route: AppRoutes.airtime,
      ),
      _BillType(
        icon: Icons.wifi,
        title: 'Data Bundles',
        description: 'MTN, Airtel, Glo, 9mobile',
        route: AppRoutes.dataBundlesHome,
      ),
      _BillType(
        icon: Icons.tv,
        title: 'Cable TV',
        description: 'DStv, GOtv, Startimes',
        route: AppRoutes.cableTVHome,
      ),
      _BillType(
        icon: Icons.router,
        title: 'Internet',
        description: 'Smile, Spectranet & more',
        route: AppRoutes.internetBillHome,
      ),
      _BillType(
        icon: Icons.water_drop,
        title: 'Water Bill',
        description: 'Water corporation bills',
        route: AppRoutes.waterBillHome,
      ),
      _BillType(
        icon: Icons.school,
        title: 'Education PINs',
        description: 'WAEC, NECO & JAMB PINs',
        route: AppRoutes.educationHome,
      ),
    ];

    return Scaffold(
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderCard(),
              SizedBox(height: 24.h),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.h,
                  childAspectRatio: 0.85,
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
  final IconData icon;
  final String title;
  final String description;
  final String route;

  const _BillType({
    required this.icon,
    required this.title,
    required this.description,
    required this.route,
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
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: InvoiceThemeColors.secondaryBackground,
          borderRadius: BorderRadius.circular(16.r),
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
              width: 60.w,
              height: 60.w,
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
                  size: 28.sp,
                  color: InvoiceThemeColors.primaryPurple,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              widget.description,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                fontSize: 11.sp,
                color: InvoiceThemeColors.textGray400,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
